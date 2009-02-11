From: Eric Kidd <git@randomhacks.net>
Subject: Re: [PATCH v2] filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 14:34:09 -0500
Message-ID: <431341160902111134l7c289412r5b3f633280beb27c@mail.gmail.com>
References: <1234361365-63711-1-git-send-email-git@randomhacks.net>
	 <1234372518-6924-1-git-send-email-git@randomhacks.net>
	 <7vhc30eqy7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 20:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKs6-0001vO-8h
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbZBKTeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbZBKTeM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:34:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:17673 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110AbZBKTeK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:34:10 -0500
Received: by yx-out-2324.google.com with SMTP id 8so183861yxm.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=aTHgt1aOIVYkje7NMybkCmq4HVciQsFMIlUcvikUyqY=;
        b=GqjUgDDE3T6aopkitzc0/de06tPE/4wlASN0GKhv7egVgBM0UZT4/LOsDU+utoTALI
         66QpvJ/XJ4Jpm8+J4ZEi/vwduup0IesoibJecL/n4y/uYjbgTPdrorr3W89goBUGyWZr
         OtHEti4zWTwKMjp4/tqHbDbUsmekCo2m+qhLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=xsn5WMuYK4q5cbYZ3puVR3me4fUgE/CyIcLEdttD3W70PKvO+/kV3iCxHhKBEQpqGU
         PDBLhS4+CSsAlIl7+bJKdkLv6J59fFoF3ryzDa27b9tWLwAKkKtVTONex3IIqQpnZfIl
         LpCsTq430xhVkerwByYY2PefRjj7eKqe1+q4E=
Received: by 10.150.91.20 with SMTP id o20mr158440ybb.238.1234380849514; Wed, 
	11 Feb 2009 11:34:09 -0800 (PST)
In-Reply-To: <7vhc30eqy7.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: 3ed64cfe5476401d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109512>

On Wed, Feb 11, 2009 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -339,7 +339,8 @@ while read commit parents; do
>>               eval "$filter_msg" > ../message ||
>>                       die "msg filter failed: $filter_msg"
>>       @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
>> -             $(git write-tree) $parentstr < ../message > ../map/$commit
>> +             $(git write-tree) $parentstr < ../message > ../map/$commit ||
>> +                     die "could not write rewritten commit"
>
> Hmm, wouldn't commit-tree have issued its own error message already?  If
> redirect failed, then the shell would have.

If a custom $filter_commit calls 'exit', there won't be an error
message from git. Of course, there may be an error message from the
custom $filter_commit, but I decided not to rely on that. Would you
prefer me to remove the error message?

I'll have another patch ready shortly, incorporating your suggestions.
My apologies for giving credit in the wrong part of the commit
message, and thank you for your feedback!

Cheers,
Eric
