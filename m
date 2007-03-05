From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH 5/7] Try to do things in the right order
Date: Mon, 5 Mar 2007 08:27:57 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703050727.l257Rv0k007635@localhost.localdomain>
References: <15303.1172917192@localhost> <87ps7qty5l.fsf@wine.dyndns.org>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO7fG-00025z-Fx
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 08:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbXCEHbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 02:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbXCEHbT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 02:31:19 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:39555 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbXCEHbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 02:31:18 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 74E2C7D13;
	Mon,  5 Mar 2007 08:31:17 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l257RwPC007638;
	Mon, 5 Mar 2007 08:27:58 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l257Rv0k007635;
	Mon, 5 Mar 2007 08:27:57 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <87ps7qty5l.fsf@wine.dyndns.org> (julliard@winehq.org)
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41405>


   From: Alexandre Julliard <julliard@winehq.org>

   Xavier Maillard <zedek@gnu.org> writes:

   > @@ -35,8 +36,14 @@
   >    (require 'vc)
   >    (require 'cl))
   >  
   > -;; Add it automatically
   > -(add-to-list 'vc-handled-backends 'GIT)
   > +;; HACK: clear up the cache to force vc-call to check again and
   > +;; discover new functions when we reload this file.
   > +(put 'GIT 'vc-functions nil)
   > +
   > +;; Add it automatically when loading vc
   > +;; FIXME: should be directly put into vc.el
   > +(eval-after-load "vc"
   > +  '(add-to-list 'vc-handled-backends 'GIT))

   That's ugly. Simply recommending that users set vc-handled-backends in
   their .emacs is easier and cleaner, I still don't see why you want to
   change it.

I'd rather want to just require or load vc-git (and that should
not be the way to go too since it should be automatically handled
by vc.el when vc-git will become part of GNU Emacs ).

By the way, do you plan to ask for inclusion into emacs ?

That's just a matter of taste, nothing more.

-- 
Xavier
