From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged' options
Date: Fri, 18 Sep 2015 21:08:42 +0530
Message-ID: <CAOLa=ZQbrE9vuES=DwO0wArdt8F_LUdFdzxggEkHFz4BB=O1OQ@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441902169-9891-3-git-send-email-Karthik.188@gmail.com> <20150917213619.GI17201@serenity.lan>
 <xmqq37ycitps.fsf@gitster.mtv.corp.google.com> <vpqoah0kxtb.fsf@anie.imag.fr>
 <20150918084208.GJ17201@serenity.lan> <CAOLa=ZQmGD2vo1B2K21-f_2RZRXduFt4VNKq2Pp9B_5bO=8=+w@mail.gmail.com>
 <vpq8u83kb5d.fsf@anie.imag.fr> <CAOLa=ZRPwoNJv9kG7GfG4ZyjHAoPa7h2PDXErZbV1_B1_ipZ7g@mail.gmail.com>
 <vpqr3lviw38.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 18 17:39:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcxkw-0005yN-LI
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 17:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbbIRPjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 11:39:16 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33296 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbbIRPjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 11:39:13 -0400
Received: by vkgd64 with SMTP id d64so32292329vkg.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P4gP4RRhTRAVJNpHXaBxhwiWTZZroBP3S1D9XtUMmzU=;
        b=IBzubwR5u2jhkc4evWZ8yUkDFFCnMVDCBac25KKGLEI2P2YU6gziTsFU909ADhzwuJ
         L3GIIcr/DKZUDrWHU0i/2Ho9amnLcmg85ktoL7xZNCzv46fpapbxulxtl5GLFkzSjgWD
         j7n9Z44fnBsPJ5OzRiZ2e6IWr5nEPlFGDTdikZqkVJXNI/U4ZXqZFmnn6fwdu6tEM35O
         eU+pA7JRJG8503lELy1iQ+P2gEHdsUkypXEC1HNKJz+JOdMcmruIv+5phQRPJXuPEdid
         9PIN5Tyv24f8b43VNp+i8m2ydPAGwmnbODLbAjo6+D1yTVpUHZr+pga0qX+hkqd52f3e
         QK8Q==
X-Received: by 10.31.194.73 with SMTP id s70mr3924350vkf.77.1442590752199;
 Fri, 18 Sep 2015 08:39:12 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Fri, 18 Sep 2015 08:38:42 -0700 (PDT)
In-Reply-To: <vpqr3lviw38.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278205>

On Fri, Sep 18, 2015 at 9:00 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Fri, Sep 18, 2015 at 8:49 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> Not sure this is much of a problem with regards to "--[no-]merged"
>>>> I mean isn't the square brackets self-explanatory?
>>>
>>> Well, usually --no-foo means "cancel the effect of --foo", ie. "git
>>> command --foo --no-foo" is equivalent to "git command".
>>>
>>> Here, --no-merged=some-ref does not _cancel_ the effect but introduce a
>>> new behavior that was not the default. So it may make sense to explain
>>> this more clearly.
>>
>> maybe we should s/no/not ? makes not sense to me
>
> It's too late to rename the option without a transition plan (people's
> finger and scripts use --no-merged already).
>
> But that would be a good idea to introduce --not-merged as a synonym to
> --no-merged, and deprecate --no-merged (it can remain a deprecated alias
> forever if needed, but we should promote --not-merged in the docs).
>

Either ways, I'll add it to my personal list of TODO.
Also having a look around, even the "--contains" option is
similarly documented:

--contains [<commit>]::
    Only list tags which contain the specified commit (HEAD if not
    specified).

About the issue at hand, we should probably squash this in

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 3803bf7..19ef640 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
        [--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
-       [--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
+       [--format=<format>] [(--merged | --no-merged) [<commit>]] [<pattern>...]
 'git tag' -v <tagname>...

 DESCRIPTION
@@ -165,10 +165,15 @@ This option is only applicable when listing tags
without annotation lines.
        that of linkgit:git-for-each-ref[1].  When unspecified,
        defaults to `%(refname:short)`.

---[no-]merged [<commit>]::
-       Only list tags whose tips are reachable, or not reachable
-       if '--no-merged' is used, from the specified commit ('HEAD'
-       if not specified).
+--merged [<commit>]::
+       Only list tags whose tips are reachable from the specified
+       commit (The `commit` may be omitted if this is the final
+       argument, in which case it defaults to `HEAD`).
+
+--no-merged [<commit>]::
+       Only list tags whose tips are not reachable from the specified
+       commit (The `commit` may be omitted if this is the final
+       argument, in which case it defaults to `HEAD`).

 CONFIGURATION
 -------------

-- 
Regards,
Karthik Nayak
