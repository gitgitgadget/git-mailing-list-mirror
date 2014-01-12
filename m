From: THILLOSEN Andreas <thillosen@free.fr>
Subject: Git: Question about specific subtree usage
Date: Sun, 12 Jan 2014 01:23:24 +0100
Message-ID: <52D1E07C.1010403@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 12 00:24:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W27uQ-0004f4-Jm
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 00:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbaAKXYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jan 2014 18:24:00 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:35440 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbaAKXXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jan 2014 18:23:36 -0500
Received: from [192.168.1.100] (unknown [88.178.152.236])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 02D728226D
	for <git@vger.kernel.org>; Sun, 12 Jan 2014 00:23:29 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240335>

Hi,

I have a question about a specific use case for subtrees, but I'm not
sure if is really possible (hence my e-mail, because all my tests failed
so far...)

>From what I have read, subtrees are used mainly to:
- Import inside a working git repository, other git repositories... it's
a little like a symbolic link pointing to another git repository, but
without the burden (it will be the main working git repository that will
handle the unified history);
- Merge many repositories into a single one (after that, they will be
seen as directories linked to the same history);
- Conversely, dispatch branches in a single repository, to make them
distinct repositories;

And now, here is my use case...

I have a big project, which contains many components (each one having,
for the moment, its own directory and repository):
MainLibrary/
MainLibrary-Tests/
Frontend1/
Frontend1-Tests/
Frontend2/
Frontend2-Tests/

MainLibrary contains the heart of the application; all other components
are linked to it when compiling.
For testing purpose, it must be possible to synchronize each component
independently (checking out MainLibrary at a specific tag level, and
checking out MainLibrary-Tests at another commit level for instance).
This is the important point... Each component must have its own history
line, and I must be able to check it out freely and independently from
the other components.

Here would be my dream... Each component would be managed by a subtree,
but ensure that:

- Components are not be tied to a same common branch... but I'm not sure
if it is possible to manage distinct history lines within a same git
history; after creating orphan branches, it becomes impossible to run
most operations like "check out");
- Any new developer would need only one basic operation to get the full
working material: clone one repo, and it's done (it would be awesome,
because in reality, my project is even bigger than my example). It would
spare us many scripting operations...
- Each component can be checked out at any desired level, and so we get
the sources of multiple components simultaneously (so far, using
subtrees or submodules, I had always the same trouble: I could only get
the sources of one component, which was the last I checked out or
activated).

Having a big shared history for all components may slow down some
operations, but it won't be a big problem for the scope of our project.
So... is my use case possible using git-magic? (I hinted subtrees, but
maybe there are better ways?)
Or must I keep my current methodology (one independant repository per
components... so each new developer must clones zillions of things at
the right place...)

Greetings,

Andreas THILLOSEN.
