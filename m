From: Shawn Pearce <spearce@spearce.org>
Subject: DAG scalability (was: Git commit generation numbers)
Date: Sun, 17 Jul 2011 15:18:19 -0700
Message-ID: <CAJo=hJvMrW4f-4Y1czR+Mx4kA=2Po+zQQXe2iOFnF7KJ=Ou3nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 18 00:18:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiZfj-0002HY-7O
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 00:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab1GQWSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 18:18:41 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:65268 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab1GQWSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 18:18:41 -0400
Received: by fxd18 with SMTP id 18so5528966fxd.11
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 15:18:40 -0700 (PDT)
Received: by 10.204.47.131 with SMTP id n3mr1539811bkf.301.1310941119858; Sun,
 17 Jul 2011 15:18:39 -0700 (PDT)
Received: by 10.204.144.195 with HTTP; Sun, 17 Jul 2011 15:18:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177320>

On Sun, Jul 17, 2011 at 12:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> The thing is, the very basic design of git is all about *incomplete*
> DAG traversal. The DAG traversal part is pretty obvious and simple,
> but the *partial* thing really is very very important. We absolutely
> need it for reasonable scalability.
=2E..
> That's a *really* fundamental design issue in git. Performance was
> always a primary goal. And by primary, I really mean primary. As in
> "more important than just about anything else". =A0There were other
> primary goals, but really not very many.
>
> And there really aren't very good ways to limit DAG traversal.

What about `git clone`?  We're always recomputing the entire DAG
during it. For a public repository like yours that only contains
public objects, its a horrible abuse of the servers that are serving
the repository...

Just saying, not everything we do winds up being a partial or
incomplete traversal in the name of performance. Sometimes we expend
1.5 minutes of CPU time *per request* on a busy server because we
don't want a cache, but then we're off in this bike shed painting
discussion about saving someone's desktop what 30 seconds of CPU time
via generation numbers in commits? Ugh. Cry me a river.

Maybe I only complain about the server side utilization of clone
because I run servers that have a lot of clone traffic.

--=20
Shawn.
