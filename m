From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/17] revert: Inline add_message_to_msg function
Date: Wed, 13 Jul 2011 01:42:40 -0500
Message-ID: <20110713064240.GC31003@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-3-git-send-email-artagnon@gmail.com>
 <20110712165302.GA13578@elie>
 <CALkWK0kHutr41aH7OrmW3REV+YBUeHSryA9n62yxyF0qRd1FEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 08:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgt9r-00074z-Sc
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 08:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab1GMGmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 02:42:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33500 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab1GMGmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 02:42:50 -0400
Received: by iwn6 with SMTP id 6so5301467iwn.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fdEBvKw7M6H9LqO0ugLgh3mD2rxVX/RAcm2HgOq9wzQ=;
        b=D3is7uKlRNoewKWNMrhaaLPlfhFp0eIcYsomDNWiuDlmbRRF8roHDJ7Aqut3GvC/RH
         whbqkz7z9Lu2rj63Hvfe0AAHa9iXauLKPBKXfBKKQ13MZKj/K+9DqvEo0tTGA9vYEJRd
         ujlzVl/+QHfbRQgZLm8byKSD77l536xRub04I=
Received: by 10.42.163.69 with SMTP id b5mr884297icy.280.1310539369277;
        Tue, 12 Jul 2011 23:42:49 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id f19sm8733529ibl.66.2011.07.12.23.42.47
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 23:42:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kHutr41aH7OrmW3REV+YBUeHSryA9n62yxyF0qRd1FEw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176996>

Hi,

Ramkumar Ramachandra wrote:

> Fixed all issues.  The commit message now reads
>
> revert: Inline add_message_to_msg function
>
> The add_message_to_msg function is poorly implemented, has an unclear
> API, and only one callsite.  Replace the callsite with a cleaner
> implementation.  Additionally, fix a bug introduced in 9509af6 (Make
> git-revert & git-cherry-pick a builtin, 2007-03-01) -- a NULL pointer
> was being dereferenced when "\n\n" was not found in "message".

That's basically the same as before, with "dereferenced" in place of
"incremented".  An improvement, sure, but it still doesn't answer the
basic questions like "how can I reproduce the bug?".

So no, in the commit message at least I don't think all issues are
fixed.  The subject line says the idea is to inline this function, but
it's actually a behavior change.  The description of the behavior
change makes reference to a variable "message" without saying what the
content of that variable is --- e.g., will trying to cherry-pick a
commit with a one-line commit message trigger this bug?  (No, it
won't.)

And honestly, making that small change and calling it fixed just feels
half-hearted and rushed.  After changing it, did you look back over
the message, read it as though unknowledgeable about the patch, and
decide whether it conveyed the right impression, which is the
equivalent of testing when writing documentation?
