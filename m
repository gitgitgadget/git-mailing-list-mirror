Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA51EB21
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="OxlHYmDW"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D113FA
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699285594; x=1699890394; i=johannes.schindelin@gmx.de;
	bh=RSvLYFBy1l7ZNOgLfWxiprWF2ZjXakKF/K+/4QD19kg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=OxlHYmDWwXic8KYUl4WYfVEeSUxCuGoeMI/5GiwQOW2t04XKten3KX5/qidnL9hR
	 KVBVoqP5iD0xDYBn9FQ4EiU/Nx7G4vGk22fYKwCtCON7NrG8wp5q7dr7W2123tSax
	 MslbS/jrMikBgvh4lVoHDrUZUGqApLYQcX7EDPmYZzmDnS/hW0n1EUJ/Navw8IlJO
	 ed42ikCFeiKDXIVH11eebaRg76b3Ce9PDEyd+FtkWQZ2T1WpHK5KzUkRXfmm6qmgW
	 oBl02D769bb9dM7+Kglh5R6n7iFoujBB9aGoCvQfrIx0MnmnM0H8za0cRj3M64sA7
	 Csa1970/WMCbZw4OaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.49]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1qwZx91vu9-00WFtW; Mon, 06
 Nov 2023 16:46:34 +0100
Date: Mon, 6 Nov 2023 16:46:32 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
    Elijah Newren <newren@gmail.com>, "Eric W. Biederman" <ebiederm@gmail.com>, 
    Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/5] merge-ort: implement support for packing objects
 together
In-Reply-To: <xmqqo7go7w63.fsf@gitster.g>
Message-ID: <0ac32374-7d52-8f0c-8583-110de678291e@gmx.de>
References: <cover.1697736516.git.me@ttaylorr.com> <cover.1698101088.git.me@ttaylorr.com> <xmqqo7go7w63.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ukBOWQISq2YqvJTYT8zvHjcNbGSM8Du5V2IfNpAIMvQxHPYrgjc
 kPLLL6NUHE0w2AAKoNOn2jP3mqaOJrdostF/08IajB+ByBqTz5kUb06LJNa1UQjikH56oKZ
 0+hxafLyHnThem4WP2EH9ODo8/e887uqXuRLgz/0zZSdn/VxRk+i5140kXgH/TetxoD3oTe
 fKIuAbL7hm3eFZCiWyUPg==
UI-OutboundReport: notjunk:1;M01:P0:BJrSjlAghGA=;PONuARr8ivgwaI6T/fFdvt68AVc
 dYd87dwXZKHQ4ea0aCZUH9r7eYjqa2n16MaeD83+DMgOi0S5ZqsRMNarFbePpgx0U/IDjekk7
 fuWh3HP0Tt4fUIzU6ooOqXA0s8mCs8LHHrvrZOJfmIGrjgMwxuXzvKcHsBnlu6KQQp5k0ABwa
 xyEqB+hfWeeSKjJDquiRZH1gZ1gPgHy9ZdXhwwiA6mrrNTODv4b/hesd/Vq/XK0voVfD+SZEy
 HUhKYh2zqKv6s3GRM2aV+G+Uz7xV4DhSCUytFV8nbvAOnjZFfD11cYRh4RragGk7eK9HWwEdd
 3lqWK7PzF+97vqms3ibkXFDBdedxit3ddpjCPfEl/rT4h6H7263/5BEPTTJs6TZJcZ9qfyPED
 dUEPv1hGMSJ4dxwYmCR3AJ1PTaTBUfl6W/wYQpnGFoc08BrW/87372vovfFKJW9l+JC4u4uWe
 SO5et65xWAJJXG+V/z1R2obK9d4hiQhxaxIqEK79XgsyyW5bB2VMjUIJ3q9KrbbFVsHzexd/9
 Rwb8erYMga1GEbnfWn8rj69DCG5xVAArdfgaMjVdj2dQdLgYClZtEYnYUpGKBDgZW8KYB+2Vo
 G6gYdJ+vthuYNJyuH433MwRTfvHsgDZiL/+SG/u77uqRAKD3SwC3dSlC6v6R20nVIGTLEaXUb
 xwTn08SbkdauxPSGagKPC+XiQeNSmmRQyJ30iNRz2Ht+p8RZnohpW++Bvw+q3KMzFfPCEJ6K0
 o7vVZpQK4rJXptLq1EwgZMGWN0NTNyaBUDJ0TG+xRgO9tSLwb43j7Mi9m3N91yZK4v06lsgRD
 vhBSGKtnue8YG/eVAC00odQohWP0hpZS5nGemZHtCUpca/I0AK5Hxin9bZRWAEqb9V95XGyry
 EhIP048ZezAtAjizhqJzfICPhMoruG7xG31hK+vv8Y9QqSSqZ0WHpgrPBb8gVwZz7Zly8e/r7
 6MZBXg==
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 23 Oct 2023, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
> > But I think that this approach ended up being less heavy-weight than I
> > had originally imagined, so I think that this version is a worthwhile
> > improvement over v4.
>
> ;-).
>
> This version is a good place to stop, a bit short of going full OO.
> Nicely done.

I wonder whether a more generic approach would be more desirable, an
approach that would work for `git replay`, too, for example (where
streaming objects does not work because they need to be made available
immediately because subsequent `merge_incore_nonrecursive()` might expect
the created objects to be present)?

What I have in mind is more along Elijah's suggestion at the Contributor
Summit to use the `tmp_objdir*()` machinery. But instead of discarding the
temporary object database, the contained objects would be repacked and the
`.pack`, (maybe `.rev`) and the `.idx` file would then be moved (in that
order) before discarding the temporary object database.

This would probably need to be implemented as a new
`tmp_objdir_pack_and_migrate()` function that basically spawns
`pack-objects` and feeds it the list of generated objects, writing
directly into the non-temporary object directory, then discarding the
`tmp_objdir`.

This approach would not only more easily extend to other commands, but it
would also be less intrusive (a `tmp_objdir_*()` call to begin the
transaction before the objects are written, another one to commit the
transaction after the objects are written), and it would potentially allow
for more efficient packs to be generated.

Ciao,
Johannes
