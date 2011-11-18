From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Fri, 18 Nov 2011 08:12:27 +0700
Message-ID: <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com> <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 02:13:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRD0q-0005QJ-MG
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 02:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab1KRBNA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 20:13:00 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45298 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1KRBM7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 20:12:59 -0500
Received: by bke11 with SMTP id 11so2793640bke.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 17:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NbNnd0TlJe4pLw88ytfjGSWxEmvLfhvDrgSqHrYfxKw=;
        b=EwSwdkMcADHVsXnxIefoFZB/Fkai+yoxATXVQvxy+ykkvN702ikLuMKMIADyno0s53
         wP0f+6E/fHIXzbaMPiIte1WuLe2WQkkq0nQSrOj2wvRbXo2ud7tXGoeYo3yRv6tfIk0a
         ewxhp5rvcn865+H0SKKoO2dMmfYKSI8INZDbM=
Received: by 10.205.131.3 with SMTP id ho3mr963533bkc.11.1321578778111; Thu,
 17 Nov 2011 17:12:58 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Thu, 17 Nov 2011 17:12:27 -0800 (PST)
In-Reply-To: <20111117134201.GA30718@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185616>

On Thu, Nov 17, 2011 at 8:42 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 17, 2011 at 04:05:52PM +0530, Ramkumar Ramachandra wrote:
>
>> The macros __FILE__, __LINE__ and __VA_ARGS__ are gcc-specific
>> extensions, no? =C2=A0I was curious to see if some other parts of Gi=
t are
>> using this: a quick grep returns mailmap.c and notes-merge.c. =C2=A0=
They
>> both use __VA_ARGS__ it for debugging purposes. =C2=A0So, nothing ne=
w.
>
> All three are in C99. I'm pretty sure __FILE__ and __LINE__ were
> available in C89, but I only have a copy of C99 handy these days.
> Variable-argument macros were definitely introduced in C99 (and were =
a
> gcc extension for a while before then).
>
>> What happens if GIT_DEBUG_MEMCHECK is set, but I'm not using gcc?
>> Also, it's probably worth mentioning in the commit message that this
>> debugging trick is gcc-specific.
>
> Older compilers will probably barf on the variable-argument macros.

Anyway to detect if __VA_ARGS__ is supported at compile time? I guess
#ifdef __GNUC__ is the last resort.

notes-merge.c introduces __VA_ARGS__ since v1.7.4 so we may want to do
something there too.
--=20
Duy
