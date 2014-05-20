From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Tue, 20 May 2014 16:41:11 -0500
Message-ID: <537bcbf7efd4_1d08f2d2f8a7@nysa.notmuch>
References: <53795175664d5_10da88d308ce@nysa.notmuch>
 <xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
 <537bc3e1c605c_a6f166b3088f@nysa.notmuch>
 <xmqqtx8krvem.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 23:52:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmrxT-0003mz-LM
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbaETVwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:52:23 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34921 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbaETVwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:52:23 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so1221569obc.29
        for <git@vger.kernel.org>; Tue, 20 May 2014 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=p+U1FK0fi0zoQitFwoBI5a8+/tlSKxxjK3G4c9aqax8=;
        b=fbQp+qMVXyijOoCbe5pIQC5Sg7GBTsU3+I5GDQM+LEG3HqKS41JsYbbGsmS5cTPwhD
         TAoWpGf8vvDkzVQCwPcWcMMqKom2rSO/zPy231lW5T9sUhoV0m8a9FeZ345TnTDP+nhp
         GUFZWgr01IMvLq0c8HfeU6gy8U0jQiLYiueeU3XctrPRXi/eH3VHeZaJVKlYk5psAPjS
         Gv11+3JdwMFk2r9+lgtZVEruqunbkYKTeS2nUDH6jma+Ve9z5YpoMVlHffREWIk1o7NG
         irbwVFdoQzYBPVK0sETeIknimYDFtOIajLJAa0LAomry851QEWxxzWB/d3OLgZ1KWdVU
         EWzA==
X-Received: by 10.182.204.73 with SMTP id kw9mr7278003obc.58.1400622742966;
        Tue, 20 May 2014 14:52:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id to6sm40004572obb.6.2014.05.20.14.52.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 14:52:22 -0700 (PDT)
In-Reply-To: <xmqqtx8krvem.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249753>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Or have an option to specify a dynamic instruction sheet, so you can cat
> > the instructions of 'match-next' and replace the base. However, I don't
> > see the point of re-applying the branches for 'next' if you already know
> > that 'next' and 'match-next' are the same.
> 
> The output from Reintegrate script (in 'todo') only lists the names
> of topic branches (or something like "xx/topic~4" when the topic is
> not fully merged yet), and a topic branch may acquire a follow-up
> change (or two) on top (there is a machinery to see if xx/topic~4
> is still valid in such a case and update the offset as needed).
> 
> Rebuilding 'jch' on top of 'master' with the same insn sheet will
> then merge the updated topic branch in its entirety, and the new
> commits on the topic branch somehow needs to go to 'next' for the
> "match next" on 'jch' and 'next' to be in sync (in addition, updated
> 'master' must be merged to 'next', but that goes without saying).
> 
> In other words, I already know that 'next' and "match next" are not
> the same, that they must become the same, and there needs a way to
> make them so.
> 
> And that is done by re-running the insn sheet for 'jch' up to the
> "match next" mark, merging the topic that are not fully merged to
> 'next' while ignoring the ones that already are fully in 'next'.

There could be a new --merge-missing option that takes the instruction
sheet of an integration branch (e.g. 'match-next'), ignores the 'base'
applies them in 'HEAD' but only when the topic branch isn't already in
'HEAD'.

I'm not sure what would be the usefulness of using things like
'xx/topic~4'.

-- 
Felipe Contreras
