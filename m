From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 10:43:19 +0700
Message-ID: <CACsJy8AStrZBtSqRiwBtonfW5y0ar=9Z371fE2Krwj=P-w7ERw@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <robbat2-20140212T015847-248245854Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 04:43:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDQjr-0005of-UW
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 04:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbaBLDnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 22:43:51 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:58807 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaBLDnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 22:43:50 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so13290110qaq.11
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 19:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EzHbKG+QeF9dIqg2t5rGdiosOrkMYIkYtfHQRXJd+gw=;
        b=UjeK35r3sBhmUNfvTQ1PPA6DVhq3pcNUcxrVl5sK1tWefwvt3r7vgkFR76+8ZkGLAR
         7rsaxOkAdVpmvBrA2Xk17FWv5kRIuBy8x8p1MfhWccVwdncrmmgFr8GaT4Tt06cHRuQS
         Z4Zekkz3qZ4bJdbRs+my5njJ7hxT8lA/vYh/LTw03yw9uIUFACWVecCx2hFRaD8rZ2W/
         mDhspi+6elEQmgdlFHNRyTtfkKejRas5QaCqTh/7XIVLSMnp97LXA0kjaF7oaifbjIpx
         D97shglyxNdlGEL+k2xQESFfevbPFvABhOpkVC0QReI5Ux8Uwdnb93hCAT4KEmraRjUe
         X9DQ==
X-Received: by 10.140.84.19 with SMTP id k19mr60147844qgd.98.1392176630163;
 Tue, 11 Feb 2014 19:43:50 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 11 Feb 2014 19:43:19 -0800 (PST)
In-Reply-To: <robbat2-20140212T015847-248245854Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241970>

On Wed, Feb 12, 2014 at 9:02 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Tue, Feb 11, 2014 at 05:54:51PM -0800,  Stefan Zager wrote:
>> We in the chromium project have a keen interest in adding threading to
>> git in the pursuit of performance for lengthy operations (checkout,
>> status, blame, ...).  Our motivation comes from hitting some
>> performance walls when working with repositories the size of chromium
>> and blink:
> +1 from Gentoo on performance improvements for large repos.
>
> The main repository in the ongoing Git migration project looks to be in
> the 1.5GB range (and for those that want to propose splitting it up, we
> have explored that option and found it lacking), with very deep history
> (but no branches of note, and very few tags).

>From v1.9 shallow clone should work for all push/pull/clone... so
history depth does not matter (on the client side). As for
gentoo-x86's large worktree, using index v4 and avoid full-tree
operations (e.g. "status .", not "status"..) should make all
operations reasonably fast. I plan to make "status" fast even without
path limiting with the help of inotify, but that's not going to be
finished soon. Did I miss anything else?
-- 
Duy
