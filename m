From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option
 bypasses the type check
Date: Mon, 2 Sep 2013 15:26:25 -0700
Message-ID: <20130902222625.GB2668@elie.Belkin>
References: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley>
 <20130901.134900.829124962244710553.chriscool@tuxfamily.org>
 <29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley>
 <20130902.081157.986549849748779440.chriscool@tuxfamily.org>
 <66A16BF0137D40568A34C316DDA6D32E@PhilipOakley>
 <20130902215545.GA2668@elie.Belkin>
 <857C171CD0E84268B296C9F3FCDFB277@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	git@vger.kernel.org, trast@inf.ethz.ch, j6t@kdbg.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 03 00:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcZu-0002eS-Kf
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759081Ab3IBW0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:26:30 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:52658 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757174Ab3IBW03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 18:26:29 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so5636631pab.12
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uVyP1tce9fMqItedhEf/Afs2mbGXXQEUyRyZkgNmsTI=;
        b=xwbr9hS0fnucJ80/8LiwHGzGYF0fRqzt7JQh1vYwOAuWEwrR4NwsxmH0tqBMDG1Xv1
         MC103BlgC+ZDzl6QDuSZb9hjD25E9nqHP9oJKReLk7ffcbOlK/HrTy7Q8uzx+fVBWz8E
         Ctmhklj/LyfiO5/J60L3vx8vZ2slof38VkaZlcHAJv4wQp23E6up5h6xD9Exx7RYKhkM
         3zNh/I81ONteiBLm9PWATY9wcKAiT2gsNo1Lg+n5NprJ7AX8SFesVlEEsUZsJ9DFhmZP
         Zb/4aZViZGdlDKSTu+GDLrkttnVl3cAfEAVdQaBilG/uzzG9ZIaS9LxdoPHAfkM8ereB
         v3Aw==
X-Received: by 10.68.178.197 with SMTP id da5mr15657143pbc.28.1378160789540;
        Mon, 02 Sep 2013 15:26:29 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id yo2sm19519124pab.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 15:26:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <857C171CD0E84268B296C9F3FCDFB277@PhilipOakley>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233672>

Philip Oakley wrote:

> The problem is the file format, in the sense that the earlier `git cat-file
> commit $orig` has a human readable output which is a description of the
> commit header, rather than the specific binary content.

Ah.  That's the actual "raw" commit object format, though.

The manpage for git-cat-file(1) says:

	SYNOPSIS
		git cat-file (-t | -s | -e | -p | <type> | --textconv ) <object>
		git cat-file (--batch | --batch-check) < <list-of-objects>

	DESCRIPTION
		In its first form, the command provides the content or the
		type of an object in the repository. [...]

	OUTPUT
		...
		If <type> is specified, the raw (though uncompressed)
		contents of the <object> will be returned.

I agree that this isn't as clear as it should be.  I see a few problems:

 (1) The synopsis treats "git cat-file -t/-s/-e/-p <object>",
     "git cat-file --textconv <tree>:<path>", and
     "git cat-file <type> <object>" as the same form of the command.
     It would be easier to explain these as three different forms.

 (2) There is no EXAMPLES section and no examples.

 (3) There is no pointer to the git object formats.  A pointer to a
     new gitobject(5) manpage would presumably make everything clearer.

https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#examining-the-data
might be a good source of text to start from for solving (1), since
it explains the command a little better.

Thanks,
Jonathan
