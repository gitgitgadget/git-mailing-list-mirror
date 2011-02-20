From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/72] gettext.h: add no-op _() and N_() wrappers
Date: Sun, 20 Feb 2011 04:34:58 -0600
Message-ID: <20110220103458.GB9340@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-2-git-send-email-avarab@gmail.com>
 <20110220020130.GA17225@elie>
 <AANLkTikkTUD=ih_KHxZ-F2gm_rNTfJ0E3Z6WXSLHBCnd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 11:35:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr6dS-0004Ox-R1
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 11:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab1BTKfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 05:35:05 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60448 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab1BTKfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 05:35:03 -0500
Received: by iyj8 with SMTP id 8so4990663iyj.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+fFuhR3tmvuiZbdlPnqmRD+uZqyT6RFdIH8bJP719Ms=;
        b=RGEyDh8wL3wZN0yKtioZ18vBrwwqz5apzQG24KOpFNZaY92QxcbbEd612SahRD4xwQ
         pgtJUd/bDH+F4O3V4zbFSA8mbwQ2U9LsVZQtzy9sp0bYPeDAuoYR7pFihJQUP9GxRjn1
         IvVv9kxqWI3ZShSBfLSCT6TyN0RgkH60bXuk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Oe6ef1HILD6LtDQWeMO8nPsA9gGtsUTU98K54wym723E+eEjSbfItTgEWL4SDHfaTx
         mwXP3GeGWfbtB+rMoWkuSw4v9BvY5gbBLIAHu2Tvbi2/P/lECvLshlsO7jirgQfx3pmy
         HADlhlu+qU173vGP0I6b/JxusmZtwlvYltBHw=
Received: by 10.42.228.10 with SMTP id jc10mr362033icb.11.1298198102697;
        Sun, 20 Feb 2011 02:35:02 -0800 (PST)
Received: from elie (adsl-69-209-79-88.dsl.chcgil.sbcglobal.net [69.209.79.88])
        by mx.google.com with ESMTPS id gy41sm3897519ibb.17.2011.02.20.02.35.01
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 02:35:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikkTUD=ih_KHxZ-F2gm_rNTfJ0E3Z6WXSLHBCnd@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167415>

Erik Faye-Lund wrote:
> On Sun, Feb 20, 2011 at 3:01 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>>> +#define N_(s) (s)
>>
>> Might be nice to make this an inline function, for type safety.
>>
>>> +#define _(s) (s)
>>
>> This one can't be a function, though, since it needs to transform
>> literals to literals.
[...]
>> +/* Mark msgid for translation but do not translate it. */
>> +#define N_(msgid) (msgid)
>
> Isn't this the opposite of what you suggested above?

Agh.  I mixed up the snippets from =C3=86var=E2=80=99s message.

N_ needs to take literals to literals, so even the non-stub version wou=
ld
be defined as

	#define N_(msgid) (msgid)

for use in contexts like

	const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] =3D {
		/* ERROR_WOULD_OVERWRITE */
		N_("Entry '%s' would be overwritten by merge. Cannot merge."),

		/* ERROR_NOT_UPTODATE_FILE */
		N_("Entry '%s' not uptodate. Cannot merge."),
	[...]

Meanwhile, in the non-stub version, _ is a synonym for the gettext()
function.

Sorry for the noise.
Jonathan
