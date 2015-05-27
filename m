From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/5] Fix verify_lock() to report errors via strbuf
Date: Wed, 27 May 2015 13:59:42 +0200
Message-ID: <5565B1AE.3010708@alum.mit.edu>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 14:00:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxa09-0001yX-8Y
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 14:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbbE0L7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 07:59:51 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46622 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750755AbbE0L7u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 07:59:50 -0400
X-AuditID: 12074413-f79386d000000d23-61-5565b1b188bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 40.DF.03363.1B1B5655; Wed, 27 May 2015 07:59:45 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0143.dip0.t-ipconnect.de [93.219.1.67])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4RBxh0s015108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 May 2015 07:59:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1N24MTXUYMYVNouuK91MFg29V5gt
	Nm9uZ3Fg9liwqdTj4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M6Yfb2UveMZZcWQeawPjB/Yu
	Rk4OCQETiacHmqBsMYkL99azdTFycQgJXGaU+Lj6NTuEc5ZJYtuteUAOBwevgLbE8TZ1kAYW
	AVWJRR+Os4HYbAK6Eot6mplASkQFgiRev8wFCfMKCEqcnPmEBcQWEVCTmNh2CMxmFrCWWN61
	FmyvsICbxIUv88DGCAm4SPRu/wZWwyngKnF7aR8TRL2exI7rv1ghbHmJ5q2zmScwCsxCsmIW
	krJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJWuEdjLtOyh1i
	FOBgVOLhzZBMDRViTSwrrsw9xCjJwaQkyrtqBVCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+1
	6UA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb8gGoEbBotT01Iq0
	zJwShDQTByfIcC4pkeLUvJTUosTSkox4UJTGFwPjFCTFA7R30nqQvcUFiblAUYjWU4yKUuK8
	m0ASAiCJjNI8uLGwVPSKURzoS2FeLpDtPMA0Btf9CmgwE9Bgs6MpIINLEhFSUg2M8Tzu6l6B
	6zJEn8tszZLQ6j/4+43wnAr7RenFyWZRZR1z513VOSX5JXazvMmjb/ouS9oUIhf5zj/DvP75
	7YNh6iUlFb3RDktCQne7W6/IN3znluT7eMP79mdLj7THMd5On7JXwL8mKGtRbDUz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270042>

On 05/23/2015 01:34 AM, Michael Haggerty wrote:
> verify_lock() is a helper function called while committing reference
> transactions. But when it fails, instead of recording its error
> message in a strbuf to be passed back to the caller of
> ref_transaction_commit(), the error message was being written directly
> to stderr.
> 
> Instead, report the errors via a strbuf so that they make it back to
> the caller of ref_transaction_commit().
> 
> [...]
> 
> This is the patch series that I mentioned here [1]. It applies on top
> of mh/ref-directory-file [2] and is thematically a continuation of
> that series in the sense that it further cleans up the error handling
> within reference transactions. It would be easy to rebase to master if
> that is preferred.

The last sentence is nonsense. This patch series relies on
lock_ref_sha1_basic() having a "strbuf *err" parameter, which is only
the case since

    4a32b2e lock_ref_sha1_basic(): report errors via a "struct strbuf
*err" (2015-05-11)

The latter commit is in mh/ref-directory-file (which has now been merged
to master, so technically the last sentence is now correct again).

Sorry for the confusion.
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
