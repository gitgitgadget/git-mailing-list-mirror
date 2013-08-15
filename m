From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 09:46:02 +0200
Message-ID: <520C873A.9070900@googlemail.com>
References: <520BAF9F.70105@googlemail.com> <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com> <vpq7gfnj38d.fsf@anie.imag.fr> <201308141725.43127.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB9475CE4F82ECE3D9C6460E7"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, iveqy@iveqy.com,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Aug 15 09:46:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9sFx-0002dN-CG
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 09:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760433Ab3HOHqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 03:46:00 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:42455 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760418Ab3HOHp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 03:45:58 -0400
Received: by mail-wi0-f180.google.com with SMTP id f14so2824947wiw.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=8AyRuTsR1pWFm5oz6n0nirnoDSuqUwiBQSsTYX230wY=;
        b=C8w45VrrpeMwul127YNSGB5Q98DotJu4Q3biMX1zdfqAYdnVoJgU2zjImRcGU7IkR7
         sBlFgQd+mVPJD2squ6ACfl5wZReOqtRdile1Bdk6HhZM6xY0759PVmUzvC3I1MOmm6Ud
         GbRblrMm46UYKbhVSwbl5kj6MOQYEChekU2EPYsBd7sF1Sjuyg8FH/6cF4ujpl61RoBB
         gB0sFKGYiTN6ViHzjBqLDtQkZdyvXP1jR2wnEySWzcFpXRI41LWUH+Za4Lv8KOue0AOu
         xAY90vRYPgUC+pt4JXr82gfM1sz4YYPKXNLzfcqxkxxONNueFXDc1R3F36VaajvEXwnn
         7lmg==
X-Received: by 10.180.20.105 with SMTP id m9mr1020903wie.44.1376552756476;
        Thu, 15 Aug 2013 00:45:56 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r6sm1324469wiw.0.2013.08.15.00.45.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 00:45:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <201308141725.43127.mfick@codeaurora.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232334>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9475CE4F82ECE3D9C6460E7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2013 01:25 AM, Martin Fick wrote:
> On Wednesday, August 14, 2013 04:51:14 pm Matthieu Moy=20
> wrote:
>> Antoine Pelisse <apelisse@gmail.com> writes:
>>> On Wed, Aug 14, 2013 at 6:27 PM, Stefan Beller
>>>
>>> <stefanbeller@googlemail.com> wrote:
>>>>  builtin/repack.c               | 410
>>>>  +++++++++++++++++++++++++++++++++++++++++
>>>>  contrib/examples/git-repack.sh | 194
>>>>  +++++++++++++++++++ git-repack.sh                  |
>>>>  194 -------------------
>>>
>>> I'm still not sure I understand the trade-off here.
>>>
>>> Most of what git-repack does is compute some file
>>> paths, (re)move those files and call git-pack-objects,
>>> and potentially git-prune-packed and
>>> git-update-server-info.
>>> Maybe I'm wrong, but I have the feeling that the
>>> correct tool for that is Shell, rather than C (and I
>>> think the code looks less intuitive in C for that
>>> matter).
>>
>> There's a real problem with git-repack being shell (I
>> already mentionned it in the previous thread about the
>> rewrite): it creates dependencies on a few external
>> binaries, and a restricted server may not have them. I
>> have this issue on a fusionforge server where Git repos
>> are accessed in a chroot with very few commands
>> available: everything went OK until the first project
>> grew enough to require a "git gc --auto", and then it
>> stopped accepting pushes for that project.
>>
>> I tracked down the origin of the problem and the
>> sysadmins disabled auto-gc, but that's not a very
>> satisfactory solution.
>>
>> C is rather painfull to write, but as a sysadmin, drop
>> the binary on your server and it just works. That's
>> really important. AFAIK, git-repack is the only
>> remaining shell part on the server, and it's rather
>> small. I'd really love to see it disapear.
>=20
> I didn't review the proposed C version, but how was it=20
> planning on removing the dependencies on these binaries? =20
> Was it planning to reimplement mv, cp, find? =20

These small programms (at least mv and cp) are just convenient
interfaces for system calls from within the shell.
You can use these system calls to achieve a similar results
compared to the commandline option.
http://linux.die.net/man/2/rename
http://linux.die.net/man/2/unlink

> Were there=20
> other binaries that were problematic that you were thinking=20
> of?  From what I can tell it also uses test, mkdir, sed,=20
> chmod and naturally sh, that is 8 dependencies.=20

mkdir, test, chmod are also easily done via system calls.
The system calls are usually capsulated by the libc to have
an easy C interface. (A standard C function call)

sed and find are tricky indeed, but you can get around it with
a few lines of C (maybe 10?) for each occurrence. We don't need
the full power of sed and find, but rather only the exact specific
matching regexp.

 If those
> can't be depended upon for existing, perhaps git should just=20
> consider bundling busy-box or some other limited shell=20
> utils, or yikes!, even its own reimplementation of these=20
> instead of implementing these independently inside other git=20
> programs?
>=20

The C version as of now has twice the lines of code than the
shell version. And I am pretty sure I did some rookie mistakes,
so the code can be down-sized by better use of already existing
functions. So I guess the final version will have less lines than
in the proposed patch as of now.



--------------enigB9475CE4F82ECE3D9C6460E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDIc6AAoJEJQCPTzLflhqHNoQAMs+UYknvtXXXNUJALOYPLnK
28cQuC9aGUiSFHGqM48JmdNYE/Qk/bQgeP4nXDf49jqGur450BL5Bww2VgvLoxiC
Mts/Ny2rbXX3KXRRc9zQ1WsHre687hNCS1v6ix5ILvMPA/hJqXLXE8QZmEnsdiec
OE45v/n9pV8l9ptMOCFrScW2oFD2lvBCgmMWfccLuYHhGEN0m6d3qSY6NwZ5DAy9
J3MEPN0poWjICLIWX18958VzjjzM9I9Y3mZ9qM1EUxi4WDF6buMY0RL/aURImfVk
eQnfvTMRL7tCqw45cj2B5srYTMfvxVVpvUtKTxqCXbnjYaElAb6xSb6KHfWk0hnR
IUEmDDdAb2+AD4bj3TNYnUU66UgjaKIhCPOO0YhH8WTCFa9THXTvJtyrq25I6ckQ
ZTkMTijDwSPK/97+W7mGDG3qO7BDGSnFvyLmRyKPSv3n+Gk8oA2kFpey0HQEJ2Rl
PcL/pOdyBcmwXC+qEWVCFkYb0ehSpqrL388LiyFR/vFp2AOpMNC6rqHRZJgnrQBB
pxP6XGuut06VaXgOD76+WX7S2fWvegiXMjwas5ZtyxVNjHiq+XW3wgZtTTqK1fRw
Z10fc35w5BjlYdUsSiPNwPZYZQ91Ipf21zBu7zTgWySg1H2WVpKLcTMPyBGFSZdj
DZ5OlSVfBdafY13vqy0c
=0tSU
-----END PGP SIGNATURE-----

--------------enigB9475CE4F82ECE3D9C6460E7--
