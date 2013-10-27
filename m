From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Sun, 27 Oct 2013 15:33:19 +0700
Message-ID: <CACsJy8CKUygqbMKK_mkOY2C5whqHN=d+6ME_jkXpPebxeSd3Tw@mail.gmail.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 09:34:29 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaLnm-0000z0-Rm
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 09:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab3J0Idw (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 04:33:52 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:43783 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3J0Idu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 04:33:50 -0400
Received: by mail-qe0-f53.google.com with SMTP id cy11so3331780qeb.12
        for <multiple recipients>; Sun, 27 Oct 2013 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4sOrI7TKd/qTGUAGNNiuciszWS7ykP1eTXTsF4I9+j0=;
        b=acrLQOoZ2lP0Piy5JxhXWab8JopWkGol/1CoJVY3T/vpAJm9pQ3dUYv2E6eH5wQCrM
         ovhnNTVxd75IKVFV1YrX3bMiqT84kLFv/zLo+O6vMwiaP73EHoXYP5ll6DCmksA1ZYM8
         WunvFVzFS3CPAUv+Mqwtu8QSJz0m5zTS/suXRWw6Vm2aaUrTAH2ulKp/PkNNqTCNqOXY
         L5hySaD8uCh94VeZ/yAf7DYbCv5cY0im+oxbcSx68gUPtgB91SpkdBhazuo88XTOv0HM
         7fvAnsh6580BpRftFSb4DWGMJOlrtqltjjuXWpB3g6pwUFSyh9oomZh6m72nrXYq9Rsn
         Rb0Q==
X-Received: by 10.229.110.8 with SMTP id l8mr21744286qcp.24.1382862829496;
 Sun, 27 Oct 2013 01:33:49 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Sun, 27 Oct 2013 01:33:19 -0700 (PDT)
In-Reply-To: <20131027013402.GA7146@leaf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236793>

On Sun, Oct 27, 2013 at 8:34 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> Add a command line option for git commit to automatically construct the
> "Fixes:" line for a commit.  This avoids the need to manually construct
> that line by copy-pasting the commit hash and subject.

But you still have to copy/paste the hash in command line. I wonder if
we should approach it differently: the user writes "Fixes: <hash>" in
the commit message, then git detects these lines and expands them
using a user-configured format. For the kernel circle, the format
would be "%h ('%s')" (I'll need to think how to let the user say
"minimum 12 chars").

Other projects need to refer to old commits sometimes in commit
messages too and this could be extended further to expand inline
abbrev sha-1s, but to not break the text alignment badly, maybe
footnotes will be created to store subjects and stuff, rather than do
inline expansion. For example,

  commit 1232343 breaks something.....

becomes

  comit 1232343 [1] breaks something....

  [1] 123234332131 (do something wrong - at this date)
-- 
Duy
