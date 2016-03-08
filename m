From: "Anton Wuerfel" <anton.wuerfel@fau.de>
Subject: Re: Adding RFC 3161 timestamps to git tags
Date: Tue, 8 Mar 2016 11:20:44 +0100
Message-ID: <10a16fd003f1cc963cf64b42a2964fdf.squirrel@faumail.uni-erlangen.de>
References: <9bf0ad940a5ce20c0c3742a3dfca70f8.squirrel@faumail.uni-erlangen.de>
    <xmqq4mcioxbz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "Anton Wuerfel" <anton.wuerfel@fau.de>, git@vger.kernel.org,
	i4passt@cs.fau.de, phillip.raffeck@fau.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 11:21:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adElJ-0007ZH-2c
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 11:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbcCHKVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 05:21:05 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:45279 "EHLO
	mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932459AbcCHKVB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2016 05:21:01 -0500
Received: from boeck5.rrze.uni-erlangen.de (boeck5.rrze.uni-erlangen.de [131.188.11.35])
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 3qKCHF0GPdzPnVP;
	Tue,  8 Mar 2016 11:20:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fau.de; s=fau-2013;
	t=1457432457; bh=hT9HnCSjvqLKPkw2rIAfCKCH17Du1dT001Bfm8EWvpg=;
	h=In-Reply-To:References:Date:Subject:From:To:Cc:From:To:CC:
	 Subject;
	b=Dw2IapxxKKNlrSor9xGx54IgZ5693nRYaB0S0HK9zTaOscpFsWKfhjmorRq8nF2FB
	 O/FOyavoBVeYOmev5R5lQJTTMAUofdsKA7M2QCZfmHHu+fWhqV0OIjwlGy0Ro+21Bf
	 c12MKcnRhFXkQlL+KYt2DdL3F3WJop4wVoxIVTK8Vd3ArsNW2YB90HtTOs56pjvPY2
	 9ekWHGUSeNf6PeydeViigDrGpbcZMkgMj1sxabAQhrE/sO7wtqdPlCLHarTiXDSsjf
	 OW6tnX9ykQuYEkwI8oJnlDh8y2EGGurcmNDFen/QcE0L+m/n99ZRgyrGSHFKyKjy8y
	 4KMHpCiJjCJ6w==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
Received: from mx-rz-2.rrze.uni-erlangen.de ([IPv6:::ffff:131.188.11.21])
	by boeck5.rrze.uni-erlangen.de (boeck5.rrze.uni-erlangen.de [::ffff:131.188.11.35]) (amavisd-new, port 10026)
	with LMTP id ufKxj4kyAPjS; Tue,  8 Mar 2016 11:20:55 +0100 (CET)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 3qKCH03s80zPnXS;
	Tue,  8 Mar 2016 11:20:44 +0100 (CET)
X-RRZE-Submit-IP: 131.188.11.38
Received: from faumail.uni-erlangen.de (smtp.uni-erlangen.de [131.188.11.38])
	by smtp.uni-erlangen.de (Postfix) with ESMTP id 3qKCH036Z2zHnm2;
	Tue,  8 Mar 2016 11:20:44 +0100 (CET)
Received: from 131.188.42.190
        by faumail.uni-erlangen.de with HTTP;
        Tue, 8 Mar 2016 11:20:44 +0100
In-Reply-To: <xmqq4mcioxbz.fsf@gitster.mtv.corp.google.com>
User-Agent: SquirrelMail/1.4.23 [SVN]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288425>

Hello Junio,

thanks for your reply. See my comments below.

"Junio C Hamano" <gitster@pobox.com> writes:

> A few random thoughts that come to mind, none of which is
> rhetorical [*1*]:
>
>  - What should happen when the timestamping service is unreachable?
>    The user cannot get her work done at all?  A tag is created
>    without timestamp and with a warning?  Something else?

If the timestamping service is unreachable, we plan to output a warning
and abort the tag creation as a default behavior. However we could create
config option to allow the user to create a tag without a signature if the
TSA (timestamp authority) is not available.


>  - Is "signed tag" the only thing that will benefit from such a
>    certified timestamping mechanism?  Would it be worthwhile to
>    offer a similar support for "signed commit"?

This is a good point. We will consider implementing this in signed
commits, too. Like in gpg-signed commits, rebases and changes of these
commits will not be possible any more without invalidating the timestamp
signature. However, the intention behind all this is to be able to verify
important steps in development and continue to be able to work and commit
without internet connection. Therefore our main focus is on tags with
timestamp signatures.


>  - How would the certified timestamp interact with GPG signing of
>    the tag?  Can they both be applied to the same tag, and if so
>    what is signed by which mechanism and in what order or are they
>    done independently and in parallel?  E.g. would the timestamp be
>    done on the contents without GPG signature, and the GPG signature
>    be done on the contents without timestamp, and both signature
>    blocks concatenated at the end of the original contents?

Both GPG and timestamp signing can be assigned to the same tag. A GPG
signature includes the timestamp signature for one important reason: It
should not be possible to replace an existing timestamp signature by
another (later) timestamp signature. Including the timestamp signature
into the GPG signature prevents this.
Creating a timestamp signature without any GPG signature at all is
therefore possible but would be vulnerable to the described scenario.


>  - Would it make sense to store the certified timestamp in the
>    object header part, like the way GPG signature for signed commit
>    objects are stored [*2*], instead of following the old-style
>    "signed tag" that concatenates a separate signature at the end?

For timestamped commits we will, of course, use the new-style format. We
would also new-style format for git tags, leaving the GPG signature as is
and creating a timesig-header. However, mixing old-style and new-style
format in tag objects would introduce an inconsistency. Is this
problematic?

Regards,
Phillip Raffeck
Anton Wuerfel
