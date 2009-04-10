From: Patrick Berkeley <patrickberkeley@gmail.com>
Subject: Re: Non-customized library and collection of customized units
Date: Fri, 10 Apr 2009 14:26:12 -0400
Message-ID: <7efce40a0904101126w151dbddi13d85780dd48fff9@mail.gmail.com>
References: <7efce40a0904101123t7fe78363vab5459469cc4014a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 20:28:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsLSN-0001MB-5m
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 20:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbZDJS03 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2009 14:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763054AbZDJS03
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 14:26:29 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:36812 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZDJS02 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 14:26:28 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1232020yxl.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=p4qpCA6FdW/SpQbff8p5j/9Kwp/9eQMcKpBMrymy0h8=;
        b=kpyuptcN2WaPy612+U63O5qK2ZihYQ1G67Xf7vX2OFXYQuX4g0IyklpjcLZIQUt/Yv
         R2r60Jd8MwJQIQq1kssq+0osJT2mJjixWtsUoz7ouchv8TKw7TP9ZXar9An5kq2W8Kj0
         H5uiXojkgbdvnmDF4v1azDW/Qi3y/J6awY52I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=jDzimbLMBIreBtczWksVsaiylb/KQxco6vxZFF0TnmKW1/FfQ9U0P0QbhNASLDdQ1c
         uuafrYVV1BngyM7YjEsW5QYxW5aMJb+9QHyX4vgJ48EaCa6WwaOZhOEL/ErHco+XaKBt
         OSSEizUwFo2rX2th2T2pzwXiScrX6VYHhx18g=
Received: by 10.150.196.5 with SMTP id t5mr2625385ybf.212.1239387987246; Fri, 
	10 Apr 2009 11:26:27 -0700 (PDT)
In-Reply-To: <7efce40a0904101123t7fe78363vab5459469cc4014a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116272>

Greetings,

I have a situation and I'd like to find out if Git would be a good
solution for it. And if it is, how to implement it. I'll describe it
in as much detail as possible, but if something's not clear, please
let me know.

We develop several courses for many clients. A few parameters:

1) Each course has several variations.
2) Each variation references customized and non-customized content.
3) The non-customized content is held in the library directory.
4) The customized content is held in a directory named a concatenation
of the client's name and course name and variation e.g.,
appleComputer_courseOne_variationFour.

I'd like to achieve several things: 1) versioning for everything,
non-customized and customized, 2) eliminate the duplication. Currently
courses are nearly exact copies of one another with the exception of a
few imgs, flvs, and xml files referencing those imgs and flvs. In
addition, the variations of a course are nearly exact duplicates of
one another with the exception of a few small changes in config.xml
file (see directory tree below).

As it stands, when we create a new variation of a course for a client
the work flow is:

1) Copy and rename a non-customized course variation to the client's
name appended with the course name and variation e.g.,
appleComputer_courseOne_variationFour.
2) Create an assets folder with flv, img, xml child directories and
place the corresponding custom flvs, imgs, and xml in these folders.
3) Modify config.xml to reference the files and directories created in =
step #2.

Below is a rough mapping of the directory tree along with a note about
each level.

|- custom (Holds all clients customized content for all courses and
their variations.)
|=A0=A0 `- Client name appended by course variation code (All content f=
or
one course and its variations. This unit and its children repeat for
each course.)
|=A0=A0=A0=A0=A0=A0 |- assets
|=A0=A0=A0=A0=A0=A0 | =A0 |- flv
|=A0=A0=A0=A0=A0=A0 | =A0 | =A0 `- Customized FLVs for this client's co=
urse variation
go here (1-3 files)
|=A0=A0=A0=A0=A0=A0 | =A0 |- img
|=A0=A0=A0=A0=A0=A0 | =A0 | =A0 `- Customized images for this client's =
course
variation go here (1-3 files)
|=A0=A0=A0=A0=A0=A0 | =A0 `- xml
|=A0=A0=A0=A0=A0=A0 | =A0=A0=A0=A0=A0 `- Customized XML for this client=
's course variation
goes here (1-3 files)
|=A0=A0=A0=A0=A0=A0 |- config.xml (This file pulls all aggregates all t=
he
customized and non-customized content, the ring to rule them all.)
|=A0=A0=A0=A0=A0=A0 `- features
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `- feature name here (All customized co=
ntent for a
feature. This unit and its children are repeated of each feature.)
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `- Custom XML and SWFs (1-3=
 files)
|- library (Holds all of the non-customized content for all courses
and their variations)
|=A0=A0 `- Course name here (All content for one course and its
variations. This unit and its children repeat for each course.)
|=A0=A0=A0=A0=A0=A0 `- assets
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |- flv
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | =A0 `- All non-customized FLVs for al=
l course variations
go here (~400 files)
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |- img
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | =A0 `- All non-customized images for =
all course variations
go here (~600 files)
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `- xml
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `- All non-customized XML f=
or all course variations
goes here (~300 files)
`- templates (Holds all templates for all courses and their variations)
=A0=A0 |- features
=A0=A0 |=A0=A0=A0 `- All SWFs for templates for all course variations g=
o here (~10 files)
=A0=A0=A0 `- pages
=A0=A0=A0=A0=A0=A0=A0 `- All SWFs for templates for all course variatio=
ns go here (~50 files)

How should I organize this using Git? Should all of the non-customized
content be in one repository with each course variation as a
submodule? Have all customized content in another repository, then
when we need to make a new course add the non-customized variation as
a submodule?

Patrick
