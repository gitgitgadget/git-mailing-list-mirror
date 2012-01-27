From: David Barr <davidbarr@google.com>
Subject: Re: commit/from command in git-fast-import
Date: Sat, 28 Jan 2012 07:56:02 +1100
Message-ID: <CAFfmPPM_xqZoMd391UdqRtK5bgW5V2z9Mg=8LYLA7ZVZQGR3Mg@mail.gmail.com>
References: <20120127124837.GA24084@glandium.org>
	<CAFfmPPPYc=9BdwuE+ANiHKrFk+_7aXDgnMv3fHxVmF0ttZu8bA@mail.gmail.com>
	<20120127140808.GA31535@glandium.org>
	<CAFfmPPN9BOp3tDetEeMjVmfFam3bgHzf=q5Am4OkTz0TqLWfbQ@mail.gmail.com>
	<20120127144702.GA6693@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 27 21:56:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqsqA-0002M6-CN
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 21:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab2A0U4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 15:56:05 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50253 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2A0U4E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 15:56:04 -0500
Received: by yenm6 with SMTP id m6so1020008yen.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=1sAhJRqRmzArWXpBCRRxB7T9toWxLKk9g9yGMnJ1IO0=;
        b=USDOYDZ2/cdtqzETjbD4OuBQwPP+rQA0JHr53EzKxRr9TndILSvDyrkyhK1CVA1+f9
         /8dZMvyfEvfGSyrpbiThnwPIogdxSrrqtyZVT/8TeI4tUc2Fiavrfzzxava6DxPoIrTP
         6DgW15gUgoHY+T4gfWYDvZ+6C+G9FfBkhA6bk=
Received: by 10.236.73.129 with SMTP id v1mr13464635yhd.129.1327697763124;
        Fri, 27 Jan 2012 12:56:03 -0800 (PST)
Received: by 10.236.73.129 with SMTP id v1mr13464618yhd.129.1327697762999;
 Fri, 27 Jan 2012 12:56:02 -0800 (PST)
Received: by 10.101.144.22 with HTTP; Fri, 27 Jan 2012 12:56:02 -0800 (PST)
In-Reply-To: <20120127144702.GA6693@glandium.org>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189232>

On Sat, Jan 28, 2012 at 1:47 AM, Mike Hommey <mh@glandium.org> wrote:
> On Sat, Jan 28, 2012 at 01:15:34AM +1100, David Barr wrote:
>> On Sat, Jan 28, 2012 at 1:08 AM, Mike Hommey <mh@glandium.org> wrote=
:
>> > On Sat, Jan 28, 2012 at 01:00:17AM +1100, David Barr wrote:
>> >> On Fri, Jan 27, 2012 at 11:48 PM, Mike Hommey <mh@glandium.org> w=
rote:
>> >> > When I do create a commit on a given branch with a stream like:
>> >> > =A0commit refs/heads/branch
>> >> > =A0author ...
>> >> > =A0committer ...
>> >> > =A0data <<EOF
>> >> > =A0Commit message
>> >> > =A0EOF
>> >> > =A0deleteall
>> >> >
>> >> > All I get is this warning:
>> >> > =A0warning: Not updating refs/heads/branch (new tip new_sha1
>> >> > does not contain old_sha1)
>> >> >
>> >> > And the branch only has one commit, which is the one I just cre=
ated.
>> >> > On the other hand, if I add a "from" instruction in the above s=
tream,
>> >> > I have the expected branch history.
>> >>
>> >> This is precisely the expected behavior.
>> >> If 'from' is omitted, the resulting commit has no preceding histo=
ry.
>> >> On the other hand, what you want is to specify the parent so that
>> >> there is a continuation of history.
>> >
>> > This is however not what the manpage suggests in what I quoted in =
my
>> > message:
>> > =A0Omitting the from command on existing branches is usually desir=
ed, as
>> > =A0the current commit on that branch is automatically assumed to b=
e the
>> > =A0first ancestor of the new commit.
>> >
>> > Mike
>>
>> Oh, right. I guess I wasn't paying enough attention, sorry.
>> That does sound like a bug then. Is it reproducible in a new repo?
>> eg:
>> =A0 git init foo && cd foo && touch bar && git add -A && git commit =
-m "baz"
>> =A0 git fast-import < ../fast-import-regression.txt
>
> It is.

I accidentally took this thread off-list.
Looks like we have a real fast-import bug, in Debian Unstable at least.
--
David Barr
