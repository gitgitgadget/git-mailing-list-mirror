From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] templates: pre-push hook: check for missing GPG signatures
Date: Wed, 24 Apr 2013 12:54:34 -0700
Message-ID: <7vppxjbt6t.fsf_-_@alter.siamese.dyndns.org>
References: <5177AB10.30209@drmicha.warpmail.net>
	<517816BD.3030203@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, joel@trustly.com, git@drmicha.warpmail.net
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:54:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5m8-0006uv-92
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565Ab3DXTyk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 15:54:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757531Ab3DXTyj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 15:54:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B3B197BE;
	Wed, 24 Apr 2013 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Wx4/icgh80vs
	/CDaoikMMM929sc=; b=EP2T2ZjWYLJz6V10K2Pc4Ek+4EXcfDcvFyDP0ny27fmB
	qllCWzetxsqFS9jI6BpnZT5y9LK5lBB2eE5m7y34VnO15n3ua4+fAo+nWgoQQfLd
	nbSamOznxDijtWzbVyNIIQOL9raOJ8AxjYMCNpqYVxUDUnfOo/aZ9q/2sOv5xXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kXUilm
	960EfMS8ryP5lb9CTMUxytDkU/DDLnvUbbUg0vy1EYYGYIoILSl8ZP8z6YRniSs8
	AqEkjnewPSUyF2eC0Rkgd6VEj16SESXvOgdcEb/zDx6QC5xJcNCKMJM6nZrNCjVv
	umw6an4QX+qmorbPWMlAMWpLkWAoRLhmraOH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45369197BD;
	Wed, 24 Apr 2013 19:54:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A313F197BB;
	Wed, 24 Apr 2013 19:54:36 +0000 (UTC)
In-Reply-To: <517816BD.3030203@physik.tu-berlin.de> ("Sebastian
 =?utf-8?Q?G=C3=B6tte=22's?=
	message of "Wed, 24 Apr 2013 19:30:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CABDE862-AD18-11E2-9E0D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222313>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> On 04/24/2013 11:51 AM, Michael J Gruber wrote:
>> Sebastian G=C3=B6tte venit, vidit, dixit 24.04.2013 10:53:
>>>                                          What could be nice would b=
e a
>>> config option that makes "git push" warn/abort in case I try to pus=
h an
>>> unsigned head commit to a repo where I want to have signed commits:
>>>> remote.<name>.abortUnsigned
>>> This of course needs a command line override switch.
>>=20
>> This appears to be more suited for a server side hook (update), or a=
 new
>> pre-push hook.
> Ok, here it is ;)
> I replaced the previous sample hook code because it did only check fo=
r commits
> containing "WIP" in their messages which I think is not terribly usef=
ul (and
> can easily be added to this script. I also added a missing colon that=
 caused my
> shell to complain about an empty if.
> This patch applies to the current master as it requires the new GPG %=
G? pretty
> placeholder output.

None of the above is part of a proper commit log message, is it?

>
> Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
> ---
>  templates/hooks--pre-push.sample | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-=
push.sample
> old mode 100644
> new mode 100755

Why?

> index 15ab6d8..08a72df
> --- a/templates/hooks--pre-push.sample
> +++ b/templates/hooks--pre-push.sample
> @@ -16,20 +16,19 @@
>  #
>  #   <local ref> <local sha1> <remote ref> <remote sha1>
>  #
> -# This sample shows how to prevent push of commits where the log mes=
sage starts
> -# with "WIP" (work in progress).
> +# This sample shows how to prevent pushing commits without good GPG =
signatures

What justifies to remove existing demonstration?  It is far easier
for the end users to remove parts that do not apply to their needs,
than coming up with a solution to add themselves without help from
an example.

>  remote=3D"$1"
>  url=3D"$2"
> =20
>  z40=3D0000000000000000000000000000000000000000
> +ec=3D0

I think it is more customary to call this kind of variable "ret" or
"retval", not an abbreviation for "european commission" ;-).

> -IFS=3D' '

Why?

>  while read local_ref local_sha remote_ref remote_sha
>  do
>  	if [ "$local_sha" =3D $z40 ]
>  	then
> -		# Handle delete
> +		: # Handle delete
>  	else
>  		if [ "$remote_sha" =3D $z40 ]
>  		then
> @@ -40,14 +39,13 @@ do
>  			range=3D"$remote_sha..$local_sha"
>  		fi
> =20
> -		# Check for WIP commit
> -		commit=3D`git rev-list -n 1 --grep '^WIP' "$range"`
> -		if [ -n "$commit" ]
> -		then
> -			echo "Found WIP commit in $local_ref, not pushing"
> -			exit 1
> -		fi
> +		commits=3D`git log --format=3D"%G? %h" "$range" | grep -v '^G' | c=
ut -d\  -f2`

Useless use of cut.  You could do

	git log ... |
        while read sign commit
        do
        	test "$sign" =3D G && continue
                echo "Found commit that is not properly signed: $commit=
"
		...
