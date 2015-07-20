From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Mon, 20 Jul 2015 14:17:57 -0700
Message-ID: <xmqqegk2y1dm.fsf@gitster.dls.corp.google.com>
References: <1437309082-19060-1-git-send-email-zoe@bytenoise.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Zoe=CC=88?= Blade <zoe@bytenoise.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 20 23:18:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHIRr-0002dJ-2g
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 23:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbbGTVSB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2015 17:18:01 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34232 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbbGTVSA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 17:18:00 -0400
Received: by pdbbh15 with SMTP id bh15so61741335pdb.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=FFvQ/doN6hf9YpwnS8N38qgkGhaoy8bVxfJJIWkklS8=;
        b=HMFKYjxo3CUS0aEALh+y6iI5xL9Du72cxuLzmR6nUYttWWiI1cShjU4JRdrGEOvVWp
         dMxumjhNIPGBXkV7fsIfItSjfAnJVCGJTbrzsRCq93QJPYbLh13G645be3MMXOE0J6tx
         kbtHt8jlSAKCsTgPmSElv9yzjUNWIIpKDoA+XxzZnmcplkVsZtSYtLlholW1j+d+Prz8
         mfBqGosDfz4yScwUmKHza8WH9WssTzdTaIFOPBNu7HfJBXUz8Kd8Ti2dz9FgJ979HKKG
         +X3FDLuEIKf3bY0CAkx7MebZvXll3RUyJYYTdRUP/YsH3v06/98t+tZnSvY22K+Mm4iz
         oNlg==
X-Received: by 10.66.158.3 with SMTP id wq3mr64399911pab.38.1437427080177;
        Mon, 20 Jul 2015 14:18:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id x7sm23582102pas.28.2015.07.20.14.17.58
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 20 Jul 2015 14:17:59 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274354>

Zoe=CC=88 Blade <zoe@bytenoise.co.uk> writes:

> diff --git a/userdiff.c b/userdiff.c
> index 2ccbee5..5a600d6 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -35,6 +35,8 @@ IPATTERN("fortran",
>  	  * they would have been matched above as a variable anyway. */
>  	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][=
a-zA-Z0-9_]*)?"
>  	 "|//|\\*\\*|::|[/<>=3D]=3D"),
> +PATTERNS("fountain", "^((\\.|(([Ii][Nn][Tt]|[Ee][Ss][Tt]|[Ee][Xx][Tt=
])?\\.?|[Ii]([Nn][Tt])?\\.?/[Ee]([Xx][Tt])?\\.?) ).+)$",
> +	 "[^ \t-]+"),

Wouldn't IPATTERN() be a better choice here?

>  PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
>  	 "[^<>=3D \t]+"),
>  PATTERNS("java",
