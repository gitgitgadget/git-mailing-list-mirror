From: ydirson@free.fr
Subject: [BUG] gitk deals badly with --not
Date: Tue, 21 Jul 2015 11:38:37 +0200 (CEST)
Message-ID: <1545730766.15139362.1437471517806.JavaMail.root@zimbra39-e7.priv.proxad.net>
References: <1236236440.15093493.1437470465599.JavaMail.root@zimbra39-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 11:39:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHU18-0000vT-E7
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 11:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbbGUJi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 05:38:58 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44400 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031AbbGUJij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 05:38:39 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CBD3BA6246
	for <git@vger.kernel.org>; Tue, 21 Jul 2015 11:38:37 +0200 (CEST)
In-Reply-To: <1236236440.15093493.1437470465599.JavaMail.root@zimbra39-e7.priv.proxad.net>
X-Originating-IP: [62.23.137.162:59075]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274370>

When gitk is run with "<some refs> --not <some other refs>" args, things work fine until one tries to modify the view.
There it considers "--not" to be an extra git-log argument on its own, and groups the negative refs together with the
positive refs, which naturally gives completely wrong results.

Not sure what the best course of action would be to fix that:
* add negative refs the extra args could be an option, since those are added last to the commandline, but then the
  "edit" dialog becomes a bit strange, with refs listed at both ends of it
* add a dedicated field for negative refs
* convert them to the ^ref syntax

Either of those last 2 solution raise the concern of convertion between ^ and --not: in the case where we add a dedicated
field, would there be any reason not to move ^refs to this field instead ?
