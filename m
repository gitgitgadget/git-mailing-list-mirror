From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Sun, 14 Nov 2010 17:48:48 -0600
Message-ID: <20101114234848.GB26104@burratino>
References: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
 <20101114215442.GC16413@burratino>
 <AANLkTiktg4aZ7VfdXUT9XF4RK7MuCvzevB5jSRaNiE1L@mail.gmail.com>
 <20101114220932.GE16413@burratino>
 <AANLkTi=JR3vVnZ4Yz8o9MpZKiQ2_ASYxahbPNv8QACir@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 00:49:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHmK7-0002Ir-Nw
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 00:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab0KNXtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 18:49:23 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41673 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab0KNXtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 18:49:22 -0500
Received: by gxk23 with SMTP id 23so2682668gxk.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 15:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uQdcfqAX51mrlqlO+7IUctmNDFYi6f1W6vU6gltNuns=;
        b=kuBOErKZD96OHaUkFcYcKlyAfD2HDhWDohIMvnzCDW0tR9ajJ/rQGBqk5Lb66j2UNi
         WjFEh5YbXZeQL4BcYF0NOY7PxNMD0HOU4rs/mul/38gQA1rJ0e49VCSKNEsq+LJ1aN+q
         o0ImFx2/UAh5/szbf4T/eSLnD8ePdcGAzl0t0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OKmvyLnlRI4i2vm+yeiEQreGU1p19U1wXb7PbqEh4+EFvlBys4liJFce5JKGge7Pha
         yw1ujoIWtWf+MA2mxXzVi+4nMHvqBPUUF2AfwGfgNr+MPm8mZEBDCEQ/vjGPUBT7hsU3
         d1X0ZS/e0lSgniUvlJ4ifO8mHKFBZ5KVl7kcc=
Received: by 10.150.97.7 with SMTP id u7mr8238794ybb.332.1289778561886;
        Sun, 14 Nov 2010 15:49:21 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id f23sm1202010ybh.22.2010.11.14.15.49.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 15:49:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=JR3vVnZ4Yz8o9MpZKiQ2_ASYxahbPNv8QACir@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161462>

Bert Wesarg wrote:

> Now I got your point. Maybe I should call GIT_EDITOR with $FILENAME as
> argument but with a new variable to indicate open'n'forget. So
> existing setups would always open the file (even without honoring the
> line number) and new/smart wrappers can honor the open'n'forget and
> line number flag.

Yes, I like the communication-via-environment idea.

In fact, there are multiple questions an editor might want answered:

1. GUI or no GUI?  (The combination of $DISPLAY and $(tty) often
   yields a reasonable answer.)

2. open'n'forget or wait for answer?  (gvim's --nofork option)

3. What line number?

4. regex to use to highlight matches?

Ideally $LINENUMBER would only be used represent (3), while a
separate variable would indicate (2).
