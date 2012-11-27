From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 13:41:32 -0800
Message-ID: <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 22:42:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSux-0001SM-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab2K0Vl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:41:56 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:58831 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab2K0Vly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:41:54 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so4405062qat.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 13:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NPPA0yxjMGuY4Bqe9jKVFHaRTsxIz4d31FzCOmryysM=;
        b=MDdpQK53krfcm6o1EI27LH6+79fSJj2MCK68bHhCuVF4U0EsHIuNyx8vDvnSnybGr5
         uniJhN4Jq2HDjlk3jyRhAYlzrC7Zk2O9urtVuML1fZBYGHY6N7fd3D9BwPaTDx0fb+Fl
         YeSf+P2uQhGXUsJ0LkQaCGZicRfijC142bAUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=NPPA0yxjMGuY4Bqe9jKVFHaRTsxIz4d31FzCOmryysM=;
        b=cz0bPHf7ijg50Hj2GK6o53d9KswMQ6tRP6ioKtxaaSd9GM+uYtDrmvcUC2pgxUINhx
         aMMoOtF0KrMEzC2Mlat6GvQmXdYapQRiWXqtuaDBFioaJpaV1SczPkZjHAAzc04VADLf
         tsitjjBn8feWxn74OKSuAFtO3pJccaGXwGPoA57ed/CnGTaUezGheIeaHJmUywazzJ1L
         /pGGMriwq+Rydz18XYt+9C+nnuU7RYwA74ODEvoungj/uyP7GqrutJ9YEVqTgIuJ/9cC
         5icUCo+JngAhoDaw6ZCqwkotCsCY53sXhR9V/9hParIEdvkCRn+eYXVPv59W27rFXyoZ
         fASg==
Received: by 10.224.185.79 with SMTP id cn15mr17679478qab.14.1354052513959;
 Tue, 27 Nov 2012 13:41:53 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Tue, 27 Nov 2012 13:41:32 -0800 (PST)
In-Reply-To: <20121127204828.577264065F@snark.thyrsus.com>
X-Gm-Message-State: ALoCoQk1BTN+pTWNn1sKN585A5X8afSvyVEMFKnJqZtQCGCI7hYW7M48GmZRHlA/BCPpaoo3iHJZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210606>

On Tue, Nov 27, 2012 at 12:48 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Because I do a lot of work on repository conversion tools, I've had
> to learn a lot of detail about ontological mismatches between
> version-control systems - especially places where you lose metadata
> moving between them.
>
> In general, git metadata can carry forward almost all the metadata in
> a Subversion repository.  Among the handful of minor exceptions (empty
> directories, flow structure, certain kinds of mergeinfos) there is one
> that stands out because it seems to be an implementation detail rather
> than a consequence of fundamentally different design decisions.
>
> I refer to the one-second precision of git timestamps.  Subversion
> stores its commit and property-change timestamps to microsecond
> precision; conversion tools have to throw the subsecond part of
> this information away.
>
> Has going to timestamps with the full precision of the system clock
> been considered and rejected, or am I the first to bring this up?
>
> If I were to write refactoring patches that treated "timestamp" as
> an ADT, with a view towards hiding the difference between int and
> float timestamps and eventually experimenting with float ones,
> would they be accepted?

JGit would fortunately ignore a floating point timestamp specification
if given in a commit, but I don't know about other Git
implementations... like say git. :-)
