From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: add option to preserve user names
Date: Sat, 07 May 2011 15:22:48 -0700
Message-ID: <7viptmup53.fsf@alter.siamese.dyndns.org>
References: <1304577819-703-1-git-send-email-luke@diamand.org>
 <7vy62k2z8j.fsf@alter.siamese.dyndns.org> <4DC38657.7020703@diamand.org>
 <20110506235912.GA11842@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun May 08 00:23:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIpty-00088R-G0
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 00:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab1EGWXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 18:23:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab1EGWW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 18:22:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F1DD54F66;
	Sat,  7 May 2011 18:25:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nd3Ut0GxYKHmdtQ/49u9yEJYXsU=; b=WnbvuB
	NHvUC3Zyz43Yg12DKpqvMDt8knIV4TBZ81tA6fc5DE9ohEqqRMU5PB/78tUD5Gd1
	3icbDoMlAxXTNnDofO5XatmHGFuHjr5DIrphU+qPGZ8rWX+6fVXUPzOrqKmcfnVc
	R14ROc7MUhFvPHBlrCCZXza3yL87Id8mJjppw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/Yvd9VnnTH+XzKER4/gbnc97kVuEOzn
	Due/8XOd5ZSGoEbQTcLfWyl7tce95dRFAmvHu0Dr6A3S1n99k6LrzdQdKeo0z793
	wnlQQgMkFkg0oip0lelIj0ZsFcOHKBH3I///LcB+uaVx0/VVRQFsU52lVzLLoJ6T
	KDs8vUDr4UI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C2124F64;
	Sat,  7 May 2011 18:24:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5971D4F63; Sat,  7 May 2011
 18:24:55 -0400 (EDT)
In-Reply-To: <20110506235912.GA11842@arf.padd.com> (Pete Wyckoff's message of
 "Fri, 6 May 2011 19:59:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8339E66-78F8-11E0-9F07-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173069>

Pete Wyckoff <pw@padd.com> writes:

> luke@diamand.org wrote on Fri, 06 May 2011 06:25 +0100:
>> On 06/05/11 06:07, Junio C Hamano wrote:
>> >Luke Diamand<luke@diamand.org>  writes:
>> >
>> >>This is version 3 of my patch.
>> >
>> >The previous one from Apr 21st is already on "next" with Ack from Pete.
>> 
>> Ah, sorry.
>> 
>> Should I submit a patch against that then?
>
> Yes, your changes look good and fix bugs.
>
> To the diff from v2 to v3:
>
> Acked-by: Pete Wyckoff <pw@padd.com>

So the only thing lacking at this point is the commit log message?

I am not sure if the "actual user is luke" message you give when (and only
when) preserveUser is used is a good "reminder".  Isn't it that the user
needs reminder when the user should have used but forgot to use this
option, not the other way around like your patch does?

I suspect that the message would show an unexpected name only when the new
codepath is buggy or the P4 changes the code is interacting are formatted
in ways that the new codepath is not expecting (well, they amount to the
same thing after all, no?), and having such a message may prevent users
from submitting the changeset under an incorrect name, but at that point
what recourse do they have?

It looks to me that the message is not helping the users, even though it
may help as a debugging aid for git-p4 developers.

-- >8 --
Subject: git-p4 --preserve-user: finishing touches

The earlier round unnecessarily updated the user field that is already
correct.

Add a message with the P4 user name used in the submit template to
remind the user when this option is given.

Form the change spec string correctly, without relying on the way
Python happens to order the dictionary contents.

Signed-off-by: Luke Diamand <luke@diamand.org>
Acked-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 36e3d87..6018507 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -688,12 +688,18 @@ class P4Submit(Command, P4UserMap):
         die("Could not get changelist number for last submit - cannot patch up user details")
 
     def modifyChangelistUser(self, changelist, newUser):
-        # fixup the user field of a changelist after it has been submitted.
+        # fixup the user field of a single changelist after it has been submitted.
         changes = p4CmdList("change -o %s" % changelist)
+        input = ''
         for c in changes:
             if c.has_key('User'):
+                if c['User'] == newUser:
+                    # nothing to do here
+                    return
                 c['User'] = newUser
-        input = marshal.dumps(changes[0])
+
+            input = input + marshal.dumps(c)
+
         result = p4CmdList("change -f -i", stdin=input)
         for r in result:
             if r.has_key('code'):
@@ -703,11 +709,10 @@ class P4Submit(Command, P4UserMap):
                 print("Updated user field for changelist %s to %s" % (changelist, newUser))
                 return
         die("Could not modify user field of changelist %s to %s" % (changelist, newUser))
-
     def canChangeChangelists(self):
         # check to see if we have p4 admin or super-user permissions, either of
         # which are required to modify changelists.
-        results = p4CmdList("-G protects %s" % self.depotPath)
+        results = p4CmdList("protects %s" % self.depotPath)
         for r in results:
             if r.has_key('perm'):
                 if r['perm'] == 'admin':
@@ -865,6 +870,10 @@ class P4Submit(Command, P4UserMap):
 
         if self.interactive:
             submitTemplate = self.prepareLogMessage(template, logMessage)
+
+            if self.preserveUser:
+               submitTemplate = submitTemplate + ("\n######## Actual user %s, modified after commit\n" % p4User)
+
             if os.environ.has_key("P4DIFF"):
                 del(os.environ["P4DIFF"])
             diff = ""
