From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 11:19:40 -0800
Message-ID: <AANLkTi=ZAPbp-qAtk=bCoi4=uEbu-F6w-8TfStXfstEL@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <4D42E1E3.4060808@viscovery.net> <AANLkTi=f34Q2VUrzA0dEG0KCFcHcd_Yq=UN6RSDPVS+p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Hawley <warthog19@eaglescrag.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 20:20:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pitre-0005U9-4t
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 20:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab1A1TUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 14:20:03 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63099 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab1A1TUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 14:20:02 -0500
Received: by fxm20 with SMTP id 20so3694134fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 11:20:00 -0800 (PST)
Received: by 10.223.98.200 with SMTP id r8mr2759593fan.30.1296242400752; Fri,
 28 Jan 2011 11:20:00 -0800 (PST)
Received: by 10.223.70.205 with HTTP; Fri, 28 Jan 2011 11:19:40 -0800 (PST)
In-Reply-To: <AANLkTi=f34Q2VUrzA0dEG0KCFcHcd_Yq=UN6RSDPVS+p@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165636>

On Fri, Jan 28, 2011 at 11:15, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Fri, Jan 28, 2011 at 10:33 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Let's define a ref hierarchy, refs/cache-pack, that names the cache pack
>> tips. A cache pack would be generated for each ref found in that
>> hierarchy. Then these commits are under user control even on github,
>> because you can just push the refs. Junio would perhaps choose a release
>> tag, and corresponding commits in the man and html histories. The choice
>> would not be completely automatic, though.
>
> This is just for bare repos, right? Why not just use HEAD?

Even on a bare repository a user might rewind his/her HEAD frequently.
 Caching from today's HEAD might not be ideal if you are about to
rewrite the last 10 commits and push those again to the repository.
That's actually where the "1.month.ago" guess came from in the patch.
If we go back a little in history, the odds of a rewrite are reduced,
and we're more likely to be able to reuse this pack.

HEAD - X commits/X days might be a good approximation if there are no
refs/cache-pack *and* gc --auto notices there is "enough" content to
suggest creating a cached pack.  But I do like Johannes Sixt's
refs/cache-pack ref hierarchy as a way to configure this explicitly.

-- 
Shawn.
