From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 15:49:18 -0800
Message-ID: <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com> <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org> <20121127230419.GA26080@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:49:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUuY-0001MH-In
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab2K0Xtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:49:39 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50319 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab2K0Xtj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:49:39 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so9279531qcr.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 15:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jZwAvywiV/ijtn0PXZl/jC/H0yPnvLXqFsBPBQm+Ubk=;
        b=Q+LpjnoD3QuqEezoBHVawX/rvtWjIN2j4DJjKFHtg+vi72pfUXEQyLVDAl7rbPz2zU
         6hDLEC+Edmj4oTtTPoYjKpc5zE4NQ1qE8jih2qbLgfQQusBt8483YuMaG/WhOwHhl9MD
         e156Ibzj0r6jU+E7Y589r27MGe5scQxi7Jq6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=jZwAvywiV/ijtn0PXZl/jC/H0yPnvLXqFsBPBQm+Ubk=;
        b=my6UIrMdFNRswcmzA+EOsZFqJvnG+848xPXH7HvcPcujczUC5C4JWeeUOHGEcbs6xZ
         MqqRhwwIgRT/KfkYm0ikQJC7KQB6WY6282nL5OqzSl/joivaiAWbE6iZA0RdW7SIK4UM
         h1OGxVlh8qpBfYRJvlYsBUVTRgbW4WmQ3FHenxmP7ZnhJNx8NgQ3Lh+3no7kOHfeA5zb
         p5GuzaOS0e46Kpel9/yJ2mTRJQHuOJsC0Gn4NfMe8e/+dhuF8azVOvclsBdpwfp7pStM
         dV1JM/IOYhY8U/CvXEn2Z4KJl6iBQVo/1EQ0Kz9DcFIlvy+EFf4wX7ltA674mefoX3VZ
         RxVA==
Received: by 10.229.174.98 with SMTP id s34mr4208398qcz.65.1354060178391; Tue,
 27 Nov 2012 15:49:38 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Tue, 27 Nov 2012 15:49:18 -0800 (PST)
In-Reply-To: <20121127230419.GA26080@thyrsus.com>
X-Gm-Message-State: ALoCoQmm+L22SIA2uUcI40EGsEFhJsMFXkRWqo2d1vyU+wW0SFN/TnKQAwSTYeNPKPTQ8TlR2YxK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210633>

On Tue, Nov 27, 2012 at 3:04 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Junio C Hamano <gitster@pobox.com>:
>> fsck_ident() in fsck.c rejects anything but " [1-9][0-9]* " after
>> the author and committer ident (i.e. the timestamp has to be
>> integral number of seconds since the epoch, not before it, nor
>> with fractional seconds).
>
> Is this architecturally significant?  It sounds like another
> implementation detail.

Well... if we added a fractional seconds to a commit, older versions
of Git will scream loudly and refuse to work with the new commit. That
would create a fork of Git.
