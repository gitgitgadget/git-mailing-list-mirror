From: neubyr <neubyr@gmail.com>
Subject: Re: git repository size / compression
Date: Fri, 9 Sep 2011 10:07:38 -0500
Message-ID: <CALFxCvyptAMU_uOzv06pe+N2W9L7ysBzcMj3YSoXH-2GGBsf-A@mail.gmail.com>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
	<1315556595.2019.11.camel@bee.lab.cmartin.tk>
	<CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
	<1315578547.4377.2.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:07:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R22gM-00022q-QU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759026Ab1IIPHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 11:07:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57288 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928Ab1IIPHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 11:07:39 -0400
Received: by wwf5 with SMTP id 5so1271071wwf.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KuWU/VmynhmBiLv5oKNRS2eqK5fCfcMcbSUDesDuLiY=;
        b=ZwShM+jeYcnecf6CzD1w04jcbTE/wAc9s+C3IYplL8ulSIdmyz15GxxpZCSRhRR2eW
         uZ3K8tcRk0/uoBoTD/++gWm5smMHxCLd3m7EOkywGtQsb0Uyh0k12p6NRJUrg6CR+9DY
         gjIgOcIZYOSz5UuvSzbQoIXpiVC/09Ga2v4B4=
Received: by 10.227.38.201 with SMTP id c9mr112043wbe.69.1315580858369; Fri,
 09 Sep 2011 08:07:38 -0700 (PDT)
Received: by 10.227.145.210 with HTTP; Fri, 9 Sep 2011 08:07:38 -0700 (PDT)
In-Reply-To: <1315578547.4377.2.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181075>

On Fri, Sep 9, 2011 at 9:28 AM, Carlos Mart=EDn Nieto <cmn@elego.de> wr=
ote:
> On Fri, 2011-09-09 at 09:04 -0500, neubyr wrote:
>> On Fri, Sep 9, 2011 at 3:23 AM, Carlos Mart=EDn Nieto <cmn@elego.de>=
 wrote:
>> > On Thu, 2011-09-08 at 21:37 -0500, neubyr wrote:
>> >> I have a test git repository with just two files in it. One of th=
e
>> >> file in it has a set of two lines that is repeated n times.
>> >> e.g.:
>> >> {{{
>> >> $ for i in {1..5}; do cat ./lexico.txt >> lexico1.txt && =A0cat
>> >> ./lexico.txt >> lexico1.txt && mv ./lexico1.txt ./lexico.txt; =A0=
done
>> >> }}}
>> >>
>> >
>> > So you've just created some data that can be compressed quite
>> > efficiently.
>> >
>> >> I ran above command few times and performed commit after each run=
=2E Now
>> >> disk usage of this repository directory is mentioned below. The 4=
19M
>> >> is working directory size and 2.7M is git repository/database siz=
e.
>> >>
>> >> {{{
>> >> $ du -h -d 1 .
>> >> 2.7M =A0 =A0./.git
>> >> 419M =A0 =A0.
>> >>
>> >> }}}
>> >>
>> >> Is it because of the compression performed by git before storing =
data
>> >> (or before sending commit)??
>> >>
>> >
>> > Yes. Git stores its objects (the commit, the snapshot of the files=
,
>> > etc.) compressed. When these objects are stored in a pack, the siz=
e can
>> > be further reduced by storing some objects as deltas which describ=
e the
>> > difference between itself and some other object in the object-db.
>> >
>>
>> Does git store deltas for some files? I thought it uses snapshots
>> (exact copy of staged files) only.
>
> Yes and no. The data model for git is to always store snapshots, and =
it
> always expects to have the full files available. In a packfile, howev=
er,
> in order to save space, some objects are stored as deltas to other
> objects in the same file.
>
> http://progit.org/book/ch9-4.html
>

Excellent.. That explains compression and deltas really well. Thanks ag=
ain..

--
neuby.r
