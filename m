From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree
	manipulation
Date: Mon, 7 Dec 2009 08:43:11 -0800
Message-ID: <20091207164311.GE17173@spearce.org>
References: <1260185254-1523-1-git-send-email-johan@herland.net> <1260185254-1523-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 17:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHggE-0006xa-0y
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 17:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935425AbZLGQnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 11:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935410AbZLGQnJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 11:43:09 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56706 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935386AbZLGQnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 11:43:08 -0500
Received: by yxe17 with SMTP id 17so4045227yxe.33
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 08:43:15 -0800 (PST)
Received: by 10.101.146.27 with SMTP id y27mr5570617ann.62.1260204194922;
        Mon, 07 Dec 2009 08:43:14 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 36sm2584448yxh.31.2009.12.07.08.43.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 08:43:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260185254-1523-2-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134766>

Johan Herland <johan@herland.net> wrote:
> +static unsigned char convert_num_notes_to_fanout(uintmax_t num_notes)
> +{
> +	unsigned char fanout = 0;
> +	while ((num_notes >>= 8))
> +		fanout++;
> +	return fanout;
> +}
> +
> +static void construct_path_with_fanout(const char *hex_sha1,
> +		unsigned char fanout, char *path)
> +{
> +	unsigned int i = 0, j = 0;
> +	if (fanout >= 20)
> +		die("Too large fanout (%u)", fanout);

Shouldn't convert_num_notes_to_fanout have a guard to prevent this
case from happening?

-- 
Shawn.
