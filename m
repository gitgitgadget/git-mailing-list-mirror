From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Tue, 28 May 2013 21:41:48 -0500
Message-ID: <51a56aec503d7_807b33e18998da@nysa.mail>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
 <1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
 <7vobbv119k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 04:44:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWNO-0001mt-67
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 04:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759407Ab3E2Coa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 22:44:30 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40020 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366Ab3E2Co3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 22:44:29 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so2175632obb.4
        for <git@vger.kernel.org>; Tue, 28 May 2013 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=e+DugURmTPfZiI6cfmC+f9xKuCC8NcyBLYFjucURpZc=;
        b=v0w06kdAQuhEkGB3BnxtTyfF3iiJUYPcy/kkDHzzwXTEItMBw0ywi7PX1XYpcFeFnH
         +I9nSa65HDKXz0bwwgGPZZZodggsX+kFl3oOPS5AS4WjbiNZE460ytRbwAVNGFT7oTor
         vGX8wM+PiTR8y+wg/nQ8TBD9HFRhC1ZLkEwIn6a8IZQIMUjnwZG1KXL6Ux6M8dXqM6yb
         Fqn2QTIaUXo8gRis0ZPTCAo9PtASODLlw/OTiILD3+i2cVJI/2XDS9FeWtoQrFYPdQei
         imXl1eTCLJPlTpJoUMpPhIwbYuW0i6fE+Zi7ZeqhpdMNpqQpqtr7tixBqeL4OBpK31Nv
         h1xw==
X-Received: by 10.60.79.231 with SMTP id m7mr372760oex.105.1369795469336;
        Tue, 28 May 2013 19:44:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm24584359obc.3.2013.05.28.19.44.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 19:44:28 -0700 (PDT)
In-Reply-To: <7vobbv119k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225702>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/revert.c  |   2 +
> >  sequencer.c       | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  sequencer.h       |   2 +
> >  t/t3500-cherry.sh |  32 +++++++++++++
> >  4 files changed, 169 insertions(+), 3 deletions(-)
> 
> "git cherry-pick" should help maintaining notes just like amend and
> rebase, but how should this interact with notes.rewrite.<command>,
> where the command is capable of doing this without an explicit
> option once you tell which notes need to be maintained?
> 
> Thomas Rast Cc'ed as he has been the primary force behind this line
> of "notes" usability.
> 
> It probably is not sensible to carry over note from a reverted
> commit to its revert, but I didn't immediately spot how the patch
> does this only for cherry-pick but not for revert (the codepath in
> do_pick_commit() is shared between them, no?).

The option is enabled from the UI, and only 'git cherry-pick' has the
--copy-notes option.

-- 
Felipe Contreras
