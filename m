From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Wed, 16 Feb 2011 09:26:17 +0000
Message-ID: <AANLkTim_0omhFW-jVRqC8TgrG7vux2-X3k1o6RFaRf0b@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <AANLkTi=1WkZXBtQu71mELTBc6F7XrfBi+NWNWy-AxS79@mail.gmail.com> <alpine.DEB.2.00.1102151940140.7843@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 10:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppdep-0001xq-E0
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 10:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758814Ab1BPJ0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 04:26:40 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34545 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab1BPJ0i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 04:26:38 -0500
Received: by ywo7 with SMTP id 7so503469ywo.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 01:26:38 -0800 (PST)
Received: by 10.100.34.15 with SMTP id h15mr149838anh.254.1297848397962; Wed,
 16 Feb 2011 01:26:37 -0800 (PST)
Received: by 10.101.48.19 with HTTP; Wed, 16 Feb 2011 01:26:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102151940140.7843@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166936>

On Wed, Feb 16, 2011 at 1:37 AM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Tue, 15 Feb 2011, Santi B?jar wrote:
>
>> On Mon, Feb 14, 2011 at 1:51 PM, Martin von Zweigbergk
>> <martin.von.zweigbergk@gmail.com> wrote:
>> > It might seem like most of the related code in git-pull.sh can be
>> > removed once git-rebase.sh supports reflog walking. Unfortunately,=
 not
>> > much of it can be removed, though. The reason is that git-pull.sh
>> > simulates one step of "reflog walking" by keeping track of the
>> > position of the remote-tracking branch before and after the fetch
>> > operation. This does not rely on reflogs. There are at least two c=
ases
>> > where the reflog is not used: a) when it is disabled, b) when the
>> > remote branch was specified on the command line (as in 'git pull
>> > --rebase origin master'). =A0In both of these cases, git-pull.sh
>> > remembers the position of the reference before the fetch and uses =
that
>> > as a kind of '$upstream@{1}'.
>>
>> I don't agree with point b). In line 190:
>>
>> =A0 =A0 =A0 remoteref=3D"$(get_remote_merge_branch "$@" 2>/dev/null)=
" &&
>>
>> It returns the local tracking branch for repo=3Dorigin and branch=3D=
master
>> and uses its reflog.
>
> Yes, but the local tracking branch is not updated when the
> two-argument version of 'git pull' is used [1].

Yes, but the reflog is used nevertheless and it can use the local
tracking branch as the old-remote-hash.

>
>> The end result is the same, there is one case where you need the old
>> value of the tracking branch, so it should be done in git-pull.
>
> True, case a) is still there. I was just trying to explain why I
> didn't just move the code from git-pull.sh to git-rebase.sh, but mayb=
e
> it confused more than it clarified...

Yes, with only case a) is sufficient (and complete).

HTH,
Santi
