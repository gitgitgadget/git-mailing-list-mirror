From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] config: Add safe-include directive
Date: Thu, 2 Oct 2014 22:34:28 -0700
Message-ID: <CAPc5daVYwLMiZzk5Dmm4v4etUhxjw3-ZjWvKEmc=RJ_mh9LFDA@mail.gmail.com>
References: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com> <1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
 <1412300254-11281-2-git-send-email-rv@rasmusvillemoes.dk> <CAPc5daV_txE9NrwvH5VWhXK+UmE7Avy8R2QaZaX0SsTC_+TU-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Fri Oct 03 07:34:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZvW2-0003sf-Bi
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 07:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbaJCFeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 01:34:50 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35891 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaJCFet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 01:34:49 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so412274lbv.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 22:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IxrChoTzCQDy+K//CRxZ1XDGsnk9CeGU7dVl+5MxLM4=;
        b=KHcf03jN5OGjw6rUMi5XhiAMji9sA35NclNQIDHsJ7U3Zy7Tkklb+2PolcfX/dWwAb
         F6JZwyf875jIr70n3G9Ewswh8dbWOQi2sRMHpimhn2oLlE9gcAAUtLJPFeGlwaHaNB8M
         +RKam4fhDkC/E4xklpezhx/S2HXIjKxDYAmtlkRXDbC4jMsHIsRmp20X/Kz9HN/udEPF
         v6UrUMZ57pL69RexOmCUM/sgu5L6Uj9WOScpdBV6FMaQo/uAvh06E4OU3D0czWLpq93m
         FJZSijGa0LogAk9dgjcwDwb9lQmat0/iVBVJNkTeUJNc3A/wx4V+0V2BxWA/XhDLTrL0
         p0IA==
X-Received: by 10.152.88.43 with SMTP id bd11mr3254363lab.62.1412314488139;
 Thu, 02 Oct 2014 22:34:48 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Thu, 2 Oct 2014 22:34:28 -0700 (PDT)
In-Reply-To: <CAPc5daV_txE9NrwvH5VWhXK+UmE7Avy8R2QaZaX0SsTC_+TU-A@mail.gmail.com>
X-Google-Sender-Auth: qV4KAMQadxOplmtf8AXW8DNEtFM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257832>

On Thu, Oct 2, 2014 at 10:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Thu, Oct 2, 2014 at 6:37 PM, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
>> This adds a variant of the include directive, where only certain
>> config variables in the included files are honoured. The set of
>> honoured variables consists of those the user has mentioned in a
>> safe-include.whitelist directive, along with a small set of git.git
>> blessed ones.

Another design decision we would need to make is if it should be
allowed for a safe-included file to use safe-include directive to
include other files. Offhand I do not think of a reason we absolutely
need to support it, but there may be an interesting workflow enabled
if we did so. I dunno.
