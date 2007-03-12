From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 14:12:53 +0100
Message-ID: <20070312131253.GA16452@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx> <20070312121226.GB2268@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joshua N Pritikin <jpritikin@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 14:13:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQkKi-0008Ho-II
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 14:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965849AbXCLNM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 09:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965839AbXCLNM5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 09:12:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:55345 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965849AbXCLNM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 09:12:56 -0400
Received: (qmail invoked by alias); 12 Mar 2007 13:12:55 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp010) with SMTP; 12 Mar 2007 14:12:55 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+LD9M64uiLu+PbNIIp7Bp6m/3RbrROHXmZdExM3z
	ZFXRJi/BxC7kjI
Mail-Followup-To: Joshua N Pritikin <jpritikin@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070312121226.GB2268@always.joy.eth.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42025>

Joshua N Pritikin <jpritikin@pobox.com> wrote:
> On Mon, Mar 12, 2007 at 12:53:50PM +0100, Matthias Lederhofer wrote:
> > git-init will always put an absolute path in
> > GIT_DIR/workdir, relative paths are resolved from the
> > directory git-init was called from.
> 
> Does that mean I can't move my GIT trees around without changing a 
> config entry? What is that an improvement?

And for the decision to put an absolute path there by default:

Putting $GIT_WORK_DIR as is into $GIT_DIR/workdir is probably not what
the user expects because the content of $GIT_DIR/workdir is
interpreted relative to $GIT_DIR, not the current working directory.
Example:

    /tmp$ mkdir repository working_directory
    /tmp$ git --git-dir=repository --work-dir=working_directory init

If git init puts 'working_directory' into $GIT_DIR/workdir it would
make the associated working directory $GIT_DIR/working_directory =
/tmp/repository/working_directory and not /tmp/working_directory.

The alternative to use

    /tmp$ git --git-dir=repository --work-dir=../working_directory init

seems quite confusing to me.

If you've any other idea to solve this please tell me.
