From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] correct verify_path for Windows
Date: Tue, 7 Oct 2008 08:25:05 +0200
Message-ID: <81b0412b0810062325o818c2f0g65de4f7811d5b8ee@mail.gmail.com>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
	 <20081004233945.GM21650@dpotapov.dyndns.org>
	 <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com>
	 <20081007032623.GX21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Joshua Juran" <jjuran@gmail.com>,
	"Giovanni Funchal" <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:26:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn61X-0003ci-MY
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbYJGGZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbYJGGZI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:25:08 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:20918 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbYJGGZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:25:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so170732and.103
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9oPWrHxs7u0XKzq7M8OgROCBkjksF7klCEwONyM3rds=;
        b=CkxaFsBAvBzt5MUBqjrOo7R3n+vTO655UVuy0k8wmStCNVkWKhEbXn683Yg7MBEFW9
         Se8T1QqBzVr/O2VUE6f3BXBtKhy8mRzaebf/f5QDVFXqAtzDzv5o5k48ey+zdRG33a4w
         nXZ/vQ66jdpbbjHdE5zxioqELA4pRAYf/eiDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ePJEepjqn0emM5jGtyLFfXIXMQ9HQGBfL9uvq5zp83dvCbUymcQHsDB2rYPV4/oZ+y
         UiSqoQZj1DUgcs/4Nw0Si8zrZUNQzj5t/bneoYN3EzMCKiLK97PXqV7VIltt8THeRdKT
         c8LaENNxszp86WFnlMmqzmbEkRTCQky3wDpJo=
Received: by 10.100.205.15 with SMTP id c15mr6138095ang.67.1223360705745;
        Mon, 06 Oct 2008 23:25:05 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Mon, 6 Oct 2008 23:25:05 -0700 (PDT)
In-Reply-To: <20081007032623.GX21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97674>

2008/10/7 Dmitry Potapov <dpotapov@gmail.com>:
> +#if defined(_WIN32) || defined(__CYGWIN__)
> +       /* On Windows, file names are case-insensitive */
> +       case 'G':
> +               if ((rest[1]|0x20) != 'i')
> +                       break;
> +               if ((rest[2]|0x20) != 't')
> +                       break;
> +#else

Maybe it is already time for FILESYSTEM_CASEINSENSITIVE?
