From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git merge auto-commit doesn't fire pre-commit hook
Date: Wed, 16 Feb 2011 23:36:09 -0500
Message-ID: <AANLkTimCdQL879kBZiktB49eSvoAGT0pX5DKX0SHFOVB@mail.gmail.com>
References: <1F3B7FF9-6348-4197-A6B7-23C4DA144920@adscale.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Liam Clarke <liam.clarke-hutchinson@adscale.co.nz>
X-From: git-owner@vger.kernel.org Thu Feb 17 05:36:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppvbh-0006yh-Pu
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 05:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab1BQEgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 23:36:42 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36610 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab1BQEgk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 23:36:40 -0500
Received: by iwn9 with SMTP id 9so2079515iwn.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 20:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ABgzpEMFVhTwrYG+kzoAzXGATIUh4GqnvU5kzhBr6yA=;
        b=OrMbtNW7XBsN9l2E0fjZZuBgf6prx1+3nCC40iJt5eEWcu4VGGiVXy0Ru2F6/W7uYF
         xpXzpLQe5n+vtj7UBnDpH5xHzqiYBaPTpXhJv3ell8/gvFRRTQb+TN10F+XIxR6SGAab
         EWRSqPqbt0hjnhj3hmaDaAFesQ3z6hIAwNITA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=j894HFrO/caZYffT4zeagiqkBHkuQ3DzqeR1q1IJjkUXACy8V2y6/1NYgpzefnDCa4
         q9BMDu4HDkCwTMckfuaRpHQc+Laf2J0BZYnK2+fn+qyLVqavJKFURAxyFOzHjzb2/TA6
         /N/UW1d3Pa2eVtSsaWTF5VVFBviLqTiCDc3PE=
Received: by 10.231.38.2 with SMTP id z2mr1178423ibd.142.1297917399855; Wed,
 16 Feb 2011 20:36:39 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 20:36:09 -0800 (PST)
In-Reply-To: <1F3B7FF9-6348-4197-A6B7-23C4DA144920@adscale.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167036>

On Wed, Feb 16, 2011 at 5:49 PM, Liam Clarke
<liam.clarke-hutchinson@adscale.co.nz> wrote:
> How exactly does git merge execute the commit?

Merge calls commit_tree directly, so the standard commit hooks are bypassed.

>  Does it use --no-verify at all? I've got a pre-commit hook to filter out testing data when merging into master, and if you merge with --no-commit, and then manually commit, the hook fires fine, but when merge autocommits, the hook doesn't get executed at all. Is there any other way to catch this event? I can add --no-commit to the branch.master.mergeoptions I suppose, but I don't want to add too much hassle for our Git users (if they're not checking in test data, of course).

I recently fixed this for prepare-commit-msg since that was the one I
cared about. See
http://thread.gmane.org/gmane.comp.version-control.git/151297 and
http://thread.gmane.org/gmane.comp.version-control.git/166805

j.
