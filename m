From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated submodules
Date: Fri, 17 Aug 2012 14:11:20 -0400
Message-ID: <CABURp0qujqHRg+PkScNGbHccHyheJZesWBsJSC=crhUczOG7Mg@mail.gmail.com>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de>
 <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de>
 <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de>
 <7vhathn0f4.fsf@alter.siamese.dyndns.org> <4FFB23EB.8060409@web.de>
 <7vpq84k9n5.fsf@alter.siamese.dyndns.org> <4FFB3DB9.6090808@web.de>
 <7vmx1uzekb.fsf@alter.siamese.dyndns.org> <502E74F8.4070209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 17 20:11:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2R1Q-0006Kw-QV
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 20:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664Ab2HQSLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 14:11:43 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39758 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab2HQSLm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 14:11:42 -0400
Received: by qcro28 with SMTP id o28so3302870qcr.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6PVnr/aO8QU1Bjw+78hgRQI70NvKssmBMdcWBu463F8=;
        b=NqAAWGYHMXijt3v35sKs1vPVKH/HUojR6GZsKMdv2SSr2rT0aBx06hJdfwr8xxyXJw
         zfSgLdyiJ8yrdlK2yKw7x6yKCoHepyrzzjdwAdZUuTi3L1EaQNsDemrK1HijZ771IgIl
         UU+JuZurzsH5Oew8Gj0hTnR76R7r14F0N7ncctvTmM5x+JUOfZMZ0JnuQjaFlX9exdVi
         JJqGAe7wzUGtqw7vifdprCV/XgwH2DENlHrmO/v9hhiC1w/AoGAwrrDeD3jdPHxQzS11
         4KBzF2DAf/x2nO1RA4G4pqQxVR+xAaavgWO0uXJTKfy2f/HzbILDW9TnGIFAHoL6jd20
         dkyA==
Received: by 10.229.137.12 with SMTP id u12mr4387851qct.28.1345227100458; Fri,
 17 Aug 2012 11:11:40 -0700 (PDT)
Received: by 10.229.52.77 with HTTP; Fri, 17 Aug 2012 11:11:20 -0700 (PDT)
In-Reply-To: <502E74F8.4070209@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203637>

On Fri, Aug 17, 2012 at 12:44 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
> I'm almost there. The only thing left is to check if a nested
> submodule is using a git directory. In that case I expect "rm" to
> fail even when -f is used to protect the submodule's history. I
> still need to find a suitable command for recursing the submodules
> and doing that check.

I suppose the style of this is wrong, but this seems to work for me.

git submodule foreach --recursive '! test -f .git'
