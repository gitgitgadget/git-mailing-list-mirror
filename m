From: Bryan Drewery <bryan@shatow.net>
Subject: Workflow question: Topic -> Next w/ frequent API changes
Date: Sat, 04 Sep 2010 11:35:01 -0500
Message-ID: <4C827535.9040907@shatow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 18:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orvqy-0000VF-Nk
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab0IDQo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:44:28 -0400
Received: from secure.xzibition.com ([173.160.118.92]:59564 "EHLO
	secure.xzibition.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab0IDQo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:44:27 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; d=shatow.net; h=message-id
	:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; q=dns; s=sweb; b=Lv5gcql7Rns0NiqVmy+
	P5HLc4808KdxKvtFXcDnFblGAuo8HywzH9iGgCDmrNGOZX5xtTmNaUG2XG06be+C
	ZJpjj/9IttfrXuo3w7vsVgv5JtVfEUDjj86lmJ8mHLqRBAYOpF+4TMTZZdmhUxmm
	s898YQvFV/Qv3r3tLsfL7z50=
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=shatow.net; h=message-id
	:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; s=sweb; bh=y7qd4jveO6y1KLZllXzd5VvsK
	ypFFOYCaZGvMkP4n3I=; b=bbcqbnTWgWA5WuzK2v1EGcbEbGy0QyaHPMe6vImgU
	aVnkxmo4OgwCRyKXc54mKghWHA/ZQVy47c6Q6N6a1JxybY91WZ2pzhbXShJ04YqG
	aQfPjCjhVM6+4h5kNDdjy5kVQNfPcfDPTlSQHbqWC1Ei9DHGmlQc4xmt7v2xj+K9
	6s=
Received: (qmail 20781 invoked from network); 4 Sep 2010 11:35:06 -0500
Received: from unknown (HELO ?10.10.1.64?) (bryan@shatow.net@10.1.10.10)
  by sweb.xzibition.com with ESMTPA; 4 Sep 2010 11:35:06 -0500
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
X-Enigmail-Version: 1.1.1
OpenPGP: id=3A809694;
	url=www.shatow.net/bryan.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155341>

 Hi,

I maintain a project at work using a similar workflow as git.git with 6
developers; I've
read gitworkflows(7) and several of Junio's emails regarding his
workflow. The project
is still maturing so we have frequent API/DB changes and do not maintain
backwards
compatibility very well.

Developers base their topics off of Next, due to the frequent API/DB
changes not in Master, and
are able to merge their topic branches into Next themselves once
completed. They rebase
their topic on top of Next at this point. They can't necessarily rebase
on Master here because
they may hit conflicts due to code not existing in Master yet.

This is my first problem, once the branch is ready to merge into Master,
I have to rebase
it on top of Master, then merge in, merge Master down into Next;
polluting the history in
Next with duplicated commits.

The other problem is that once their topic has been merged into Next,
and before it has
been merged into Master, it may be found that another commit is needed
on their topic
to fix an issue. Due to frequent API/DB changes, they might 'git pull
Next' into their topic
branch, so they can properly test the new fix. Obviously this makes
things difficult once
the topic is ready for Master, and I have to manually cherry-pick their
commits into a
new branch to get rid of the 100s of Next commits they merged in.

What's the best solution for handling this? Should we just be resetting
Next after releases
to remove the pollution?

I'm thinking that we need to incorporate subsystem maintaining/branching
as well, and
group up like subsystem changes into the same releases. Though we still
run into problems
where every file in the system needs updating for new API. Perhaps our
workflow is just completely
wrong?

Any input would be appreciated.

Thanks in advance,
Bryan Drewery
