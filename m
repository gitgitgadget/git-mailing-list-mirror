From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: Re: [PATCH 4/4] gitweb: Fix broken blob action parameters on blob/commitdiff pages
Date: Tue, 09 Apr 2013 22:17:09 +0200
Message-ID: <m2d2u3a27u.fsf@zahir.fritz.box>
References: <m2vc7wbx76.fsf@blackdown.de> <51643307.9090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 22:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPeyu-0004wg-U8
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 22:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936063Ab3DIURY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 16:17:24 -0400
Received: from mail-bk0-f47.google.com ([209.85.214.47]:54537 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936059Ab3DIURX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 16:17:23 -0400
Received: by mail-bk0-f47.google.com with SMTP id ik5so3760167bkc.34
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:cc:subject:in-reply-to:references:user-agent
         :date:message-id:mime-version:content-type:content-transfer-encoding;
        bh=uBcer63i1+FlSepITrfolrsYFj+o/Ne7Te+u1BlWv30=;
        b=j2o/1UsytuXplxsnnhsmFPaY00F8iO+xBSOR1Qpz6Yn4i+Ta7yW/QmHhFerUTSEL14
         vmG+76EuL8lCeoJSy9xQLakB362L4mFJnnc/smKVZSRMx+u8pBIMWtC0HN92EKbgnzPj
         hsNSHJsL4RQXwFPB8TudRjM33ja032MzCfWIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:in-reply-to:references:user-agent
         :date:message-id:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=uBcer63i1+FlSepITrfolrsYFj+o/Ne7Te+u1BlWv30=;
        b=UJ2G2ku91MOl8AW7vA9TCZvYW0UJeJOokz6q9I1DjeY/zBFFB0ZY+pjQzLDbwjYyak
         AW5cluyOPz/jjxE88hNVZwEmB6xT0mwwPGRCssJM5wScOuH1n3mgKq5grjoxKqYfIUb/
         gZvEOEC2GJ/7XvQ1LP0KENARUD9QNCYZLZPcuFHbIqDxLjuos3ELk0d9hVPviNEXqWZo
         +Mqv8MconzFzttjKf+LFziEoEknc/mFdV46h1WTrC5aAbAHXH5uKN8V39hWEL4R3had7
         i8vvlZSho//Ec+JVa9eZDkfNHjhUthjsAyXQmMHFlttwL+JnCkU9+DGokDSAp+J9SfhX
         yrbA==
X-Received: by 10.205.13.194 with SMTP id pn2mr2942469bkb.76.1365538642356;
        Tue, 09 Apr 2013 13:17:22 -0700 (PDT)
Received: from zahir.fritz.box (p5083D2BC.dip.t-dialin.net. [80.131.210.188])
        by mx.google.com with ESMTPS id gy3sm14575923bkc.16.2013.04.09.13.17.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 13:17:21 -0700 (PDT)
In-Reply-To: <51643307.9090603@gmail.com> ("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Tue,
	09 Apr 2013 17:25:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQnWRGRS98zZDpjbETS/vJd7kVCdlIG06PZcisEAHAc7xvLz0RIR/8DsbPr/YqflsKaVS6zk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220627>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 08.04.2013 22:10, J=C3=BCrgen Kreileder pisze:
>
>> Fix broken blob action parameters on blobdiff and commitdiff pages b=
y
>> explicitly passing variables instead of relying on global ones.
>
> Do I understand it correctly that those variables (e.g. $hash variabl=
e
> in git_patchset_body in second chunk below, after this change passed
> as parameter to format_diff_cc_simplified()) can be filled in then,
> or at least adjusted correctly?

Yep.

>> (The broken parameters on blob links lead to blob pages which show t=
he
>> blob but with a hash instead of a commit message and have broken
>> blob_plain (404 - Cannot find file) and tree links (404 - Reading tr=
ee
>> failed))
>
> I wonder how we missed this.  Does this happen always, or in some
> specific conditions?

Just having a hash in the diff header and missing navigation links for
lhs links in diffs happen pretty much all the time:
E.g. follow any a/... link on http://repo.or.cz/w/alt-git.git/commitdif=
f/5bda18c186e455f8e65f976d3bf333ab1f4b5b53

(Btw, on
http://repo.or.cz/w/alt-git.git/blobdiff/6466fbbeef67ec398f6f5d5b5da5d6=
f107a647b2..5bda18c186e455f8e65f976d3bf333ab1f4b5b53:/GIT-VERSION-GEN
both the a/ und b/ link are broken.  No idea if my patch fixes that, I
don't use pathinfo because I've had similar problems with it when I
tested it a year ago).

Broken a/ and b/ + broken tree + broken blob_plain links are more
rare.  I see them on
https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3Dblobdiff;f=3D=
Classes/ContactAlbum.h;h=3D8f2b6a772ba0a4530e0c441db53ae5bbc0f2e277;hp=3D=
03c43ea01a3a88bbce3c73df9bfde64ee7a13717;hb=3Dcc4eaa64c2b399dd9bdbf1f67=
f6d621aa24df5f8;hpb=3D43ff97d2c247517f43d83314aaa215e9f61d5d0c;js=3D1
for example:
When following either a/ or b/, all links in "[contactalbum.git] /
Classes / ContactAlbum.h" are broken.

With my patch I don't see these problems:
https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblobdiff;f=3DClasses=
/ContactAlbum.h;h=3D8f2b6a772ba0a4530e0c441db53ae5bbc0f2e277;hp=3D03c43=
ea01a3a88bbce3c73df9bfde64ee7a13717;hb=3Dcc4eaa64c2b399dd9bdbf1f67f6d62=
1aa24df5f8;hpb=3D43ff97d2c247517f43d83314aaa215e9f61d5d0c;js=3D1


        Juergen
