From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive
 pruning
Date: Fri, 29 Apr 2016 08:56:28 +0200
Message-ID: <5723059C.5080406@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
 <xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
 <1461788637.11504.3.camel@twopensource.com>
 <xmqqh9em93xo.fsf@gitster.mtv.corp.google.com>
 <xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 08:56:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw2Lu-00048c-G5
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 08:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbcD2G4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 02:56:34 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60204 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753154AbcD2G4d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 02:56:33 -0400
X-AuditID: 1207440d-bc7ff7000000090b-c3-572305a04ee6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C9.A5.02315.0A503275; Fri, 29 Apr 2016 02:56:32 -0400 (EDT)
Received: from [192.168.69.130] (p548D6182.dip0.t-ipconnect.de [84.141.97.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3T6uSh7010285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 29 Apr 2016 02:56:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqLuAVTncYOIJNov5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrR3YPHbOusvu8ax3D6PHxUvKHvuXbmPzWPD8PrvH501yAWxR
	3DZJiSVlwZnpefp2CdwZbROXMhdckKpY8n8SUwPjLtEuRk4OCQETiR137jB3MXJxCAlsZZRY
	s+I7G4Rznkli46mFTCBVwgKBEj8/fWIDsUUEIiQaXrUwQhSdZJJ4/6IFrINZYAejxK2HXWBV
	bAK6Eot6msG6eQW0JY5f7GMHsVkEVCWeLr/ECGKLCoRIbFv3jRWiRlDi5MwnLF2MHBycAtYS
	Nw5Gg4SZBfQkdlz/xQphy0tsfzuHeQIj/ywkHbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJu
	cXJiXl5qka6RXm5miV5qSukmRkiA8+5g/L9O5hCjAAejEg/vjHtK4UKsiWXFlbmHGCU5mJRE
	eXVuAIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8DYyKIcL8aYkVlalFuXDpKQ5WJTEedWWqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeJtZgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLi
	QVEZXwyMS5AUD9De/SDtvMUFiblAUYjWU4yKUuK8ZSAJAZBERmke3FhY2nrFKA70pTDvT5Aq
	HmDKg+t+BTSYCWiwwCZFkMEliQgpqQZGRT6fX0F9WX479286c3pjb+RENg3LTXVOasf2m2S3
	lm/+Jmbl7OR7+4FWWpJSxYyNc+YtqNvXr7LHOqBZW3rWrGLxtB2JhraOt88KPmTw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292972>

On 04/27/2016 11:15 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> If a casual reader sees this code:
>>
>>     ref_transaction_delete(transaction, r->name, r->sha1,
>> 			   REF_ISPRUNING | REF_NODEREF, NULL, &err)
>>
>> it gives an incorrect impression that there may also be a valid case
>> to make a "delete" call with ISPRUNING alone without NODEREF, in
>> other codepaths and under certain conditions, and write an incorrect
>>
>>     ref_transaction_delete(transaction, refname, sha1,
>> 			   REF_ISPRUNING, NULL, &err)
>>
>> in her new code.  Or a careless programmer and reviewer may not even
>> memorize and remember what the new world order is when they see such
>> a code and let it pass.
>>
>> As I understand that we declare that "to prune a ref from set of
>> loose refs is to prune the named one, never following a symbolic
>> ref" is the new world order with this patch, making sure that
>> ISPRUNING automatically and always mean NODEREF will eliminate the
>> possibility that any new code makes an incorrect call to "delete",
>> which I think is much better.
> 
> ... but my understanding of the point of this patch may be flawed,
> in which case I of course am willing to be enlightened ;-)

I was thinking of this patch as documenting and enforcing a limitation
in the current implementation of pruning. But to be honest I can't think
of a reason that we would ever want to remove this limitation, so I am
OK with changing the policy to "REF_ISPRUNING always implies
REF_NODEREF" as you have suggested.

But I think it would be cleaner to achieve that goal with the following
change:

diff --git a/refs.c b/refs.c
index 5dc2473..1d4c12a 100644
--- a/refs.c
+++ b/refs.c
@@ -790,8 +790,10 @@ int ref_transaction_update(struct ref_transaction
*transaction,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");

-	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
-		die("BUG: REF_ISPRUNING set without REF_NODEREF");
+	if (flags & REF_ISPRUNING) {
+		/* Pruning is always non-recursive */
+		flags |= REF_NODEREF;
+	}

 	if (new_sha1 && !is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8fcbd7d..9faf17c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2116,7 +2116,7 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
+				   REF_ISPRUNING, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 37a1a37..704eea7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -15,7 +15,7 @@

 /*
  * Used as a flag in ref_update::flags when a loose ref is being
- * pruned.
+ * pruned. This flag implies REF_NODEREF.
  */
 #define REF_ISPRUNING	0x04


Note that patch "add_update(): initialize the whole ref_update" should
then be adjusted to do the flag-tweak in the add_update() function.

If there are no objections, I will implement these changes in v2.

Michael
