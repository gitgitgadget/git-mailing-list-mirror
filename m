From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Tue, 15 Nov 2011 14:43:33 +0530
Message-ID: <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com> <7v7h33oifq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 10:14:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQF5e-0008R4-D8
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 10:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab1KOJN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 04:13:56 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38179 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab1KOJNz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 04:13:55 -0500
Received: by wyh15 with SMTP id 15so6792148wyh.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 01:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=v7tPjybfMbMwu5UUNaZBkrHplEe+oCamve83eKrSPx4=;
        b=vN5kW1WUwufo0UAmxUoUi+v4lj1EU9gSbjSpNGSX3NA0VOSdIkvVY8Pu4bOkwJ4+se
         XsbnIPWVHuTcjeDotPDc6H2fu/UQv5lp2waQoF8BT81pG2s0G3Cz9p1C9mkBz2q005Fg
         yI3guwb95AFCw38dYij3Bq1Cvvu4EzVZLKJis=
Received: by 10.216.188.145 with SMTP id a17mr4274089wen.24.1321348434362;
 Tue, 15 Nov 2011 01:13:54 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 01:13:33 -0800 (PST)
In-Reply-To: <7v7h33oifq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185446>

Hi,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>>> =C2=A0static int create_seq_dir(void)
>>>> =C2=A0{
>>>> + =C2=A0 =C2=A0 const char *todo_file =3D git_path(SEQ_TODO_FILE);
>>>> =C2=A0 =C2=A0 =C2=A0 const char *seq_dir =3D git_path(SEQ_DIR);
>>>
>>> Scary idiom.
>>
>> What's scary about it?
>
> The next person who copies and pastes this code to other codepaths wi=
thout
> thinking that the return value of git_path() is ephemeral and may nee=
d to
> be saved away depending on what goes between its assignment and its u=
se.

Yeah, git_path() writes to one of the four static buffers in
path.c:get_pathname().  Which brings me to: what should (can) we do
about it?  Explicitly xmalloc()'ing and free()'ing a tiny path buffer
is an overkill, so I'm thinking more on the lines of good
documentation.  I've been guilty of misusing git_path() blindly in the
past myself.

Thanks.

-- Ram
