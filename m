From: Mike Hommey <mh@glandium.org>
Subject: Ambiguous sha-1 during a rebase
Date: Thu, 14 Apr 2016 07:29:19 +0900
Message-ID: <20160413222919.GA10474@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 00:29:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTI0-0001Ig-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbcDMW31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:29:27 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:32872 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108AbcDMW3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:29:25 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1aqTHj-0003ko-Rq
	for git@vger.kernel.org; Thu, 14 Apr 2016 07:29:19 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291502>

Hi,

Something interesting happened to me. I was in the middle of an
interactive rebase, and after a --continue, I got:

error: short SHA1 e34ff55 is ambiguous.
fatal: Needed a single revision
Invalid commit name: e34ff55

One thing that happened, is that, while running that interactive rebase,
I /also/ did a `git remote update` from an other shell, which, I guess,
happened to have imported another object that made e34ff55 ambiguous.

Should git-rebase use full sha-1s under the hood to avoid these type of
races?

Relatedly, having looked up the ambiguity, it turns out the other object
that fits the same short sha1 is a tree... maybe git should be able to
disambiguate in that case, since it was looking for a commit, and
there's only one commit with that short sha1?

Mike
