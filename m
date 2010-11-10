From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Tue, 9 Nov 2010 19:53:27 -0600
Message-ID: <20101110015327.GB1503@burratino>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
 <20101104112530.5c0e444a@chalon.bertin.fr>
 <4CD2E7B4.3000908@nextest.com>
 <vpq62wddmc0.fsf@bauges.imag.fr>
 <20101104181020.GB16431@burratino>
 <20101104205307.GA8911@home.lan>
 <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, kevin@sb.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 02:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFzsu-0008Qp-As
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 02:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0KJBxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 20:53:52 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40695 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab0KJBxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 20:53:50 -0500
Received: by gwj21 with SMTP id 21so67562gwj.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 17:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5we4ykDt6Z/MXTSNpg8KmNc4bQNKxtu3yGfoqODS2rc=;
        b=stCb5vBN0Kgnthl1YCsAYnMS2t4U84H1eQPHAOM6AVZvv2HA6p2Nd3Z+lPsG4xT3Lk
         dk/Fd0IAdKWewpCDX1p4VZmm74rWaQv1TwY81OyfEPdHrfnA/OmXm0YokTZWgV/zA97y
         ITCeZRcd5u14jymZOYujEpAz9XHrrQDXjvwPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DX318C9eqVOLIjhAygm9pW/O8D13AKoSblS+a814FcxIslfW2N8l623DcArJUVRulg
         dC1cyhKWES7LGiqerNlgdkVvqN1JNE20yqVaxFzrEk/ZBq5Ohzqq3M/z3OZiz5hw0gmC
         93q5oJibpw6A5IDwzM5UL0RDuCrzo+TlU7/S4=
Received: by 10.150.203.5 with SMTP id a5mr4077281ybg.438.1289354029422;
        Tue, 09 Nov 2010 17:53:49 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m65sm76395yha.23.2010.11.09.17.53.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 17:53:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161120>

Junio C Hamano wrote:
> Yann Dirson <ydirson@free.fr> writes:

>> #  e, edit = use commit (if specified) but pause to amend/examine/test
[...]
>                     would it be crystal clear that, if he changed the insn
> sheet to
> 
>     pick one
>     edit
>     pick three
>     ...
> 
> then he will _lose_ the change made by foo, or will the user come back
> here and complain that a precious change "two" is lost and it is git's
> fault?

If we explain it clearly then I think yes, the end user would not
be confused.

The above description (that starts with "e, edit") looks more like a
reminder than a full explanation.  Can we rely on the perplexed
operator to read the text after the command list?

If so, some trailing explanation[1] might help.

# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit (if specified), but stop to amend/examine/test
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#  x, exec = run command using shell, and stop if it fails
#
# The argument to edit is optional; if left out or equal to "-",
# it means to stop to examine or amend the previous commit.
#
# If you remove a line here, THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
# Use the noop command if you really want to remove all commits.

[1] http://thread.gmane.org/gmane.comp.version-control.git/160691/focus=160742
