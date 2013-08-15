From: Erik Bernoth <erik.bernoth@gmail.com>
Subject: Re: Understanding Git Under The Hood: Trees
Date: Thu, 15 Aug 2013 21:32:07 +0200
Message-ID: <CAB46HOmVpMFsu9dWwB+TZW+DQmE-5XOZqJf62Ufz7ak0eGxP5g@mail.gmail.com>
References: <CAB46HOnsOdYyt3sEe=iv3AJu_BDpTqCLKUpTBFQSnVGMZc8r8A@mail.gmail.com>
	<520CCC53.4090308@op5.se>
	<7vwqnmrhbw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 21:32:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA3HZ-0008JV-96
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 21:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759496Ab3HOTcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 15:32:11 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43312 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758528Ab3HOTcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 15:32:09 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so558182eek.19
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NurocFrjDesEJNZMAOJ98Y2EJ7SkNi668VGtZYbx3cc=;
        b=k76+vhi16/+FJVfk6fi4LP158YfwqhnfZ0MEMsW2FQVNa3YR5J1PF+UKPhLTfDkVbZ
         9VCa/gAOI1ApTZWhUCi4bCHyxj1EUoxPIP066F/DsfXQ26wnBD1ahdkFCcsECT47GOjg
         lJjp+1yV6uSnUiZUIkiJq4E6iWSwoqCnUG7gmQ5+YbKlJzZSWTBVojqN4m+HBRpSEc3t
         AilV6pPmUDcUPUeLBNAHOzc3exOa1vR1Ampf/vfCvxXo8CtYfX1VAPi7yv13Ok5LM13q
         Z9oUqzm0uT4xvhuI+UG4p0R50z+spiTygleXZ70P5JX97a13L1yxseBuoGcZiwotcj1r
         NLGA==
X-Received: by 10.15.56.8 with SMTP id x8mr1550422eew.83.1376595127802; Thu,
 15 Aug 2013 12:32:07 -0700 (PDT)
Received: by 10.223.4.70 with HTTP; Thu, 15 Aug 2013 12:32:07 -0700 (PDT)
In-Reply-To: <7vwqnmrhbw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232363>

On Thu, Aug 15, 2013 at 7:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> While the last statement applies to other parts of the system, it is
> not true for the in-core index design.  We always had a flat index,
> and it is not cheating at all.  The original "tree" was also a flat
> representation of everything under the sun, and hierarchical tree
> objects came much later.

To some degree that revalidates my interpretation of Andreas'
statements. If I understand it correctly eacht time a shell command is
executed, which requires tree interaction, the corresponding tree is
read from filesystem to memory completely before anything is done? So
if I git-add a file, the whole index is read first, then the memory
object is changed and then the resulting change is written to disk
bottom-up from the point of view of the tree?
