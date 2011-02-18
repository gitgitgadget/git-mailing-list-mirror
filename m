From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Thu, 17 Feb 2011 19:59:02 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102171957350.14950@debian>
References: <1297860417-21895-1-git-send-email-olsonse@umich.edu> <4D5CC9C9.60705@viscovery.net> <alpine.DEB.2.00.1102171929200.14950@debian> <201102171748.15516.olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:59:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEgl-0008Mr-AB
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146Ab1BRA7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:59:11 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58854 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236Ab1BRA7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:59:06 -0500
Received: by vws16 with SMTP id 16so1565898vws.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=8S53WTLKVB7E3Hees0u72XXQM/j90vuVB8Nzr8AEygU=;
        b=wcunt8V1Gtzxd78JXncsy/B0rFASl4e8oQaeXW3n6wEOohdnfJqGCmidO45vxJMmu0
         ZvhCBTLaBo4UyLcTyY7pjazawT/DTUqRWpORAkR7shm4av0o+Sp51yY0kS6gmWhxEyAZ
         uhUJGrWljeHtbsa7jHys69nuw9RmL5OkNSrq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=RL8QFqNayAB/gh/OjKtuXk1CoC/xPDS7bYRU5BFgk8mqHHoFm5SCiy8Df7kupU189E
         jgjTeifrnwj3dK/zLcATiov8ftzJ4MwY2JvjzWrsF4aSOEau94Uu+FHhn/PzZSMGizhB
         uHPnSRBAp7O39d/8BW6MPjeu5WB5gNNqBNglg=
Received: by 10.52.156.233 with SMTP id wh9mr148968vdb.180.1297990745581;
        Thu, 17 Feb 2011 16:59:05 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y15sm769625vch.29.2011.02.17.16.59.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 16:59:04 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201102171748.15516.olsonse@umich.edu>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167148>

On Thu, 17 Feb 2011, Spencer E. Olson wrote:

> We are not actually using the yes utility (think y\ny\ny\ny\ny\ny\n...)
> 
> As far as I understand, in this particular use, "yes" and "no" are just 
> comments.  We could also write
> : I like banannas ;;
> and
> ! : I do not like anchovies ;;

Ah, I'm sure you're right. Need to read up on that colon operator. Thanks.

> 
> On Thursday 17 February 2011 17:34, Martin von Zweigbergk wrote:
> > On Thu, 17 Feb 2011, Johannes Sixt wrote:
> > > Am 2/16/2011 20:51, schrieb Junio C Hamano:
> > > > Here is how to write the above more concisely, efficiently and
> > > > portably.
> > > >
> > > > 	case "$2;" in
> > > >         *";$1;"*)
> > > >         	echo yes ;;
> > > >         *)
> > > >         	echo no ;;
> > > > 	esac
> > > >
> > > > The trailing ';' takes care of the case where cloned_modules has only
> > > > one element, in which case you have ";name" in "$2".  No need for a
> > > > loop.
> > >
> > > And while you are here, you could make this:
> > >
> > > list_contains()
> > > {
> > > 	case "$2;" in
> > > 	*";$1;"*)
> > >
> > > 		: yes ;;
> > >
> > > 	*)
> > > 		! : no ;;
> > > 	esac
> > > }
> > >
> > > and test for the exit code of this function rather than its output at the
> > > call site.
> >
> > According to Brandon Casey: "Some platforms (IRIX 6.5, Solaris 7) do
> > not provide the 'yes' utility." See 8648732 (t/test-lib.sh: provide a
> > shell implementation of the 'yes' utility, 2009-08-28).
> >
> >
> > /Martin
> 
