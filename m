From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to
 be more useful
Date: Fri, 3 Dec 2010 02:55:28 -0600
Message-ID: <20101203085528.GE18202@burratino>
References: <20101110015327.GB1503@burratino>
 <1290629960-60917-1-git-send-email-kevin@sb.org>
 <20101203080603.GC18202@burratino>
 <048EACFB-2038-4D49-B6C3-7E7354F62171@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Dec 03 09:56:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORR2-0001nf-CP
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab0LCIzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 03:55:43 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62255 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0LCIzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:55:43 -0500
Received: by gwj20 with SMTP id 20so4646035gwj.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 00:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QHHoddB5RHFtBssnufauruGeqXVNOeQgl31dJ9FhEbw=;
        b=I4b98nnXJgSSV3ljy19B+CV9FSJsxuZ/6UWP6LmbI5gX3J39eK2MkhRx3PnOxR/L5M
         iY8qYnp8AUoWvt7uKPQf0vt3s0NP74ptUwY9JE8sT0p9M4IZGdAd45t44enkd+Ge0xF0
         K1lQqri3PXMZnLbHyjPhxS644x0dD57bD0fRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=x2JN/H7pGwlzDTHKFdGSikW6kpyKQNHXGFmVy1QFIxAim860sMLnTAW4v04f41vjNz
         YVvgYiX1x8WzVrUUlS4Dg4P13/LFssaW1020bSJYI6LK14dIt01LAmVz+S15ayc/qDij
         zfJPsOiqYNAGpvW2j+Th4Ttjqpl4zMAZ3LZi0=
Received: by 10.150.203.6 with SMTP id a6mr3280335ybg.236.1291366540912;
        Fri, 03 Dec 2010 00:55:40 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id a44sm333970yhc.10.2010.12.03.00.55.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 00:55:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <048EACFB-2038-4D49-B6C3-7E7354F62171@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162776>

Kevin Ballard wrote:
> On Dec 3, 2010, at 12:06 AM, Jonathan Nieder wrote:

>> Maybe something like
>> 
>> 	rebase-i: treat "edit" without sha1 as a request to amend previous commit
>> 
>> would make the meaning more obvious in a shortlog.
>
> That seems a bit misleading, though. This command really has nothing to do with
> amending the previous commit.

Okay, maybe

	rebase-i: extend "edit" to allow stopping without a commit to amend

Or something else entirely; I only meant that "to be more useful" is
a bit vague (it could be cut out without loss of meaning).

>> Maybe this can be done without relying on details of --pretty=oneline
>> format?
>> 
>> 			sha1=$(git rev-parse --short HEAD)
>> 			rest=$(git show -s --format=%s HEAD)
>
> Does this not similarly assume that rev-parse and show will not fail? Or was
> the above comment only meant to point out this potential issue without
> suggesting that it needed to be fixed?

Yes, that's right.  The exit status from rev-list is ignored
throughout the script; making that more robust is a separate topic.

BTW this suggestion about avoiding --pretty=oneline was nonsense ---
the output format from

	git rev-list --pretty=oneline

is guaranteed to stay the same because rev-list is plumbing.  Sorry
for the noise.

Good night,
Jonathan
