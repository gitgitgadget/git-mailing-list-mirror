From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: 'git grep needle rev' attempts to access 'rev:.../.gitattributes'
 in the worktree
Date: Wed, 10 Oct 2012 12:17:53 +0700
Message-ID: <CACsJy8Cku-XTbQBDpZpPh7AMDFMoNKLKeJNs5HKCQnBy420d2w@mail.gmail.com>
References: <5073E87D.9020100@viscovery.net> <CACsJy8BFmUr5_E47900T6j9Lgdvj96_dNbo2LHP5hLYq3w7ZLA@mail.gmail.com>
 <20121009120144.GA8780@do> <20121009124144.GB12465@sigill.intra.peff.net> <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:18:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLogm-0006bQ-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 07:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab2JJFS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 01:18:26 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33595 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2JJFSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 01:18:25 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so100404qch.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 22:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NxyWE2Gau7+fGpfGWqJl7JTHNHzG2E76GT182cfqw68=;
        b=Iuk++AAXUGH/bWkYJMwlChkkc4jFuxXs9OBBkvupDCN3qOvwHx2Fa0kpsuXiXTs2rk
         bnflsxJNahdtRLn8yf6E9EqSCNazrtYXj4Qr6a+0ZP+YP2rcSo0LPZwmtptC7GgVUf8w
         vPNPh+Y8Tq5zq123eizZ3BTSRaniU667Md4pRqnp5PH0eWRS0s5E4NwwMxUeKhFJOtLk
         ryBjt893K361M4FHSD0udsNQgamIRMCbpD13y+6MFipkC0Yx4i/7CjwFpKyJ1/ZlgfZr
         5tbR5JcHQDuKuqgoXLOEaUkzF0N32Kt0NOi4wRsZvWVjmpAUZvSAV8X3YWiiTbkNLyA2
         eozA==
Received: by 10.49.81.161 with SMTP id b1mr54587275qey.21.1349846304195; Tue,
 09 Oct 2012 22:18:24 -0700 (PDT)
Received: by 10.49.13.194 with HTTP; Tue, 9 Oct 2012 22:17:53 -0700 (PDT)
In-Reply-To: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207362>

On Wed, Oct 10, 2012 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I think we just need to have callers of grep_source_init provide us with
>> the actual pathname (or NULL, in the case of GREP_SOURCE_BUF). That is
>> where the information is lost.
>
> Yes.  I agree that is the right approach.

Passing full path this way means prepare_attr_stack has to walk back
to top directory for every files (even in the same directory). If
.gitattributes are loaded while git-grep traverses the tree, then it
can preload attr once per directory. But Jeff's approach looks
simpler.
-- 
Duy
