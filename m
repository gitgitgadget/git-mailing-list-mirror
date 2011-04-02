From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Completion for branches or tags broken with zsh
Date: Sat, 2 Apr 2011 17:50:45 -0500
Message-ID: <20110402225045.GA22781@elie>
References: <1jxqbmc.vc0luayavmrkM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Lodato <lodatom@gmail.com>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Apr 03 00:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q69em-0001F6-KU
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 00:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280Ab1DBWuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 18:50:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52902 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab1DBWuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 18:50:55 -0400
Received: by iwn34 with SMTP id 34so4589413iwn.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Whe4hnIWZoylLX1OTRG0CRVXw0OIdShUu7ECeVIyKxQ=;
        b=PUto36Avy1MlqIP54PJFElkiMGgDNYBPGc4VTG6LXp+1Bp0kdlLeYXShCqWI9SAWIl
         1ZdjuZrcCn0sTaQTi9T4ZcvQFWSHg+//lK+tvTlKJzz5ybNQI3HnrbF5vkgnrlUzkBVP
         GdfXwlF0tWX8+7eQqtE+IuYMK6WRr9e6xXDxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QCXMKhB7or8a8nsxZmP0f+qtKmJqvYMyZV0ifgcCFemNqRj4A5irFE7n/7L0axBqdd
         cdxj5TYQjUhJmXmdV/B7Ki6fBwd7HgvPOgy+HQQXg+jeV7iEfLNUTxHkxL8A4lQLGO0Y
         dED68cHEAr+JXfWRHrpRjf61UlFJWxbBVtRYQ=
Received: by 10.43.57.131 with SMTP id wg3mr2055437icb.299.1301784654358;
        Sat, 02 Apr 2011 15:50:54 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id wu1sm2297465icb.10.2011.04.02.15.50.51
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Apr 2011 15:50:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1jxqbmc.vc0luayavmrkM%lists@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170665>

Hi Stefan,

Stefan Haller wrote:

> In the current master (and 1.7.4), tab completion for refs doesn't work
> in zsh.  When typing "git log orig<TAB>", nothing appears.

Sorry for the long silence.  Indeed, it seems that I broke this in
da48616f1d (bash: get --pretty=m<tab> completion to work with bash v4,
2010-12-02).  No fix yet.

Here's the puzzle: _git calls _get_comp_words_by_ref to fill the local
array "${words[@]}".  It doesn't succeed.  Within _get_comp_words_by_ref,
${words[@]} gets filled correctly, but within _git, it keeps the value it
previously had.

Alas, that's as far as I can get without learning something about zsh. :)
I can't reproduce it when defining functions like this directly, so
there might be something subtle going on.

Hints?

Thanks for noticing.
Jonathan
