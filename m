From: Erik Bernoth <erik.bernoth@gmail.com>
Subject: Index Fileformat: stat(2) info necessary? What for?
Date: Mon, 26 Aug 2013 14:34:18 +0200
Message-ID: <CAB46HOmMtgD+CtWUS3CQhr+ux1a3JP=hF2Cerd2nmDWzX5pxcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 26 14:34:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDvzz-0007kL-PH
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 14:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377Ab3HZMeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 08:34:19 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:57127 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab3HZMeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 08:34:19 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so1567838ead.19
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=aB8tkJadvYWlZmzsJ9GxgrnDKqUWKd5YNPW5a24QJl4=;
        b=RcuJwzjlp1/ILIsDnOaOWEe17/T2SZXUcxVGfcCUMlHBBgKV1/TEFwG9rDqQMolVBY
         EWT+6Wy+cf2Zauw4fmcLJNoabz9LjsEZBsgqRHRl70Sgfv6Z/R6zIwg/a0NoNnn8z/+8
         DInJY128S7B/YREwYyJqylJXZxekYFNy3UUqAh32Cp8goc23goWNkuiHAyMDsGfXpZAl
         s6ROZsMofbJ3fMBD6KgHVIa8yGamriLn65Pb5bl0hZyWK2eug3Q8ernQzqCLCBopbU/T
         nxQ/st9Wy9edMKxPWDhTgOof8aX1Ptg/S0zSIFy7VuLGwl6hlsnQRFW4Ksfz/eEJ3bf4
         MPdg==
X-Received: by 10.14.181.132 with SMTP id l4mr2281711eem.77.1377520458189;
 Mon, 26 Aug 2013 05:34:18 -0700 (PDT)
Received: by 10.223.4.70 with HTTP; Mon, 26 Aug 2013 05:34:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232991>

Hi,

I am still working on implementing git in Python for self education
purposes. Implementing the Index in memory was no problem after I
understood how its done with help of Andreas Ericsson and Junio C
Hamano.

Now I want to store an Index state to the filesystem in a
git-compatible file format. I looked up what the Git documentation has
to say about that [1]. Now there's a lot of information (all the
stat(2) stuff) that gets stored about the staged files, which I never
needed for file-IO in Python or Java. In my eyes if a person would be
cloning my git repository he wouldn't need it as well, because the new
inode on his system will probably be different from mine and applying
the access rights onto the cloning user id and group id would also
make sense, because that user introduced that file to that system.

Thus I am now missing concrete experience in when this stat(2)
information comes in handy or if it would be completely okay in a
python-git implementation to just store the info shown with `git
ls-files -s` to a file, maybe zlib.compressed like a git object. Of
course I would then lose the compatibility with git repositories,
which is a shame even if it would make sense. What is your opinion?


[1] https://github.com/git/git/blob/master/Documentation/technical/index-format.txt


Cheers
Erik
