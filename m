From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3 3/3] Smart-http tests: Test http-backend without
	curl or a webserver
Date: Sat, 2 Jan 2010 13:03:18 -0800
Message-ID: <20100102210318.GN6914@spearce.org>
References: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com> <1262465119-96115-3-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 22:03:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRB8A-0006CI-DR
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 22:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab0ABVDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 16:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916Ab0ABVDW
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 16:03:22 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:39072 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0ABVDW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 16:03:22 -0500
Received: by gxk3 with SMTP id 3so1806476gxk.1
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 13:03:21 -0800 (PST)
Received: by 10.101.105.25 with SMTP id h25mr32599726anm.63.1262466201307;
        Sat, 02 Jan 2010 13:03:21 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm15882887iwn.11.2010.01.02.13.03.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 13:03:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262465119-96115-3-git-send-email-tarmigan+git@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136052>

Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
>  GET() {
> -	return 0
> +	REQUEST_METHOD="GET" \
> +	run_backend "/repo.git/$1" &&
> +	grep "Status" act.out >act
> +	if [ $? -eq 1 ];

I think this should be spelled as:

	if ! grep "Status" act.out >act; then
		printf "Status: 200 OK\r\n" > act
	fi

-- 
Shawn.
