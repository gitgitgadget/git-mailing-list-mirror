From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Mon, 16 Apr 2012 04:04:38 -0700
Message-ID: <CACz_eyfEpE8nZua3JkYtSV42aR_CKJRwvz=4TbOw2zCqSJuDOw@mail.gmail.com>
References: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
	<1332482108-2659-1-git-send-email-lucian.poston@gmail.com>
	<4F6C4C90.5050702@in.waw.pl>
	<CACz_eyc0AjvU0U2FGzqhUTZ_nncuFoAxZ6VGw0=7LVXH4SLqwA@mail.gmail.com>
	<4F86ABA7.8080703@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Apr 16 13:04:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjjf-0004kC-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 13:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab2DPLEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 07:04:39 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:63683 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab2DPLEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 07:04:38 -0400
Received: by dake40 with SMTP id e40so6772740dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Y+/rVEOC27FJD6SbRrKsLLqiqjxr2L1GjNfvKFg12LU=;
        b=SbKRpGE6LYCxRPYtZFCJUyaYxZn24QK8Qwqo+6Gt5yCPSu5CEBJEYF3Y+IX+5JOE0l
         ggn2qCMJe5pX2sQ66rnZqmm5WhAoorEf2vE7KnyqueP2NcWF874GIQ29et2b83kNBUh7
         xAuaQ9/FlpNjGLNY7SzlZlH+6oHqQbp66ncH1uR5AV62v+Lsl6BBw4NK8aBq+vX5rt4o
         d+hVzUU52nVLo/p3PcOqd3fQhjnSf6BZ/BCPaWNQU9OFKU6xD0rcvl4U4IQEzA0DUtyX
         15Og44csyAYWE7+L9OdprJxRQJtObISTBxl7jgg/b5QRjG5k/uraRegD4WHxgEbbAftE
         9+1Q==
Received: by 10.68.194.1 with SMTP id hs1mr27244323pbc.6.1334574278304; Mon,
 16 Apr 2012 04:04:38 -0700 (PDT)
Received: by 10.68.238.74 with HTTP; Mon, 16 Apr 2012 04:04:38 -0700 (PDT)
In-Reply-To: <4F86ABA7.8080703@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195621>

On Thu, Apr 12, 2012 at 03:17, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If the remaini=
ng unreserved space will not accomodate
>>>> the
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* filenames, adj=
ust name_width to use all available
>>>> remaining space.
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Otherwise, ass=
ign any extra space to graph_width.
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (name_width> =C2=A0=
 =C2=A0width - reserved_character_count -
>>>> graph_width) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 name_width =3D width - reserved_character_count -
>>>> graph_width;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graph_width =3D width - reserved_character_count -
>>>> name_width;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If stat-graph-=
width was specified, limit graph_width to
>>>> its value.
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (options->stat=
_graph_width&&
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graph_wi=
dth> =C2=A0 =C2=A0options->stat_graph_width)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graph_width> =C2=A0 =C2=A0options->stat=
_graph_width)
>>>> {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 graph_width =3D options->stat_graph_width;
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (name_width> =C2=A0=
 =C2=A0width - number_width - 6 - graph_width)
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 name_width =3D width - number_width - 6 -
>>>> graph_width;
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graph_width =3D width - number_width - 6 -
>>>> name_width;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> Here, the order of the two tests
>>> (1) if (options->stat_graph_width&& =C2=A0graph_width>
>>> =C2=A0options->stat_graph_width)
>>>
>>> (2) if (name_width> =C2=A0width - number_width - 6 - graph_width)
>>> is reversed. This is not OK, because this means that
>>> options->stat_graph_width will be used unconditionally, while
>>> before it was subject to limiting by total width.
>>
>>
>> If options->stat_graph_width is specified, it should always limit th=
e
>> value of graph_width, correct? Since (1) is the last test, it can on=
ly
>> decrease the value of graph_width, which would already be limited by
>> the total width.
>
> Right, but the way the tests are ordered now, we could end up decreas=
ing
> name_width first (after (2)) and then graph_width (after (1)), actual=
ly
> using less than full width.

Ahh, I didn't think about that.

I just reverted the order back to the original.

>> I just noticed that name_width isn't being limited to stat_name_widt=
h,
>> if it is specified. I'll add a check for that.
>
> Sounds good.

=46YI, in patch v3, I reverted the check for stat_graph_width as previo=
usly
mentioned, and I ended up not adding a check for stat_name_width.
It remains the case that in certain scenarios, name_width & graph_width
could be set to values greater than stat_name_width & stat_graph_width.
