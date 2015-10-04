From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] git-p4: Fix t9815 git-p4-submit-fail test case on OS X
Date: Sun, 04 Oct 2015 11:23:09 -0700
Message-ID: <xmqqegha1oj6.fsf@gitster.mtv.corp.google.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
	<1443981977-64604-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 04 20:23:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZinwR-0002FV-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbbJDSXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:23:12 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33823 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbbJDSXL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:23:11 -0400
Received: by padhy16 with SMTP id hy16so13319042pad.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=e6fmNcNCuX5R3WvvbubMRJyIHscTNzoxgbYxbfzEsuk=;
        b=FNnmL09Z+kr/mrXZTL+eZFbk5APQCpLUJymCt2Dxx9tLDK9Lke3pIwe0cBQbIwHflj
         nMCw7PVh0hrNtJRD9VfJlFTUMtHNSA0f4R71D+71qwI3iNR2vMWEtGkl+g/SNcwrx1EU
         aCAEjKdvLc2xqk1sH7ctPB7bo3LGwVJE3tKOrXCk5iKUaGTIVxeRvM2YsCZql153wlwO
         axU70pEPBs3p8ycJwZdQrEnEwxmq65g4dq3dxb3AsMRpfqCylysfS8E53/TOgx1OH6xH
         qf+RAPpktG1SvBR8Un2eWccPfu2/RzRfBPdVANd1Wey06mJmjgui4HQg4LappSgphj8J
         mvrQ==
X-Received: by 10.66.146.69 with SMTP id ta5mr35038461pab.46.1443982991361;
        Sun, 04 Oct 2015 11:23:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id tp6sm23089239pbc.81.2015.10.04.11.23.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:23:10 -0700 (PDT)
In-Reply-To: <1443981977-64604-4-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 4 Oct 2015 11:06:16
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279016>

larsxschneider@gmail.com writes:

> +		if test_have_prereq CYGWIN; then
> +			: # NOOP
> +		elif test_have_prereq DARWIN; then
> +			stat -f %Sp text | egrep ^-r-- &&
> +			stat -f %Sp text+x | egrep ^-r-x
> +		else
>  			stat --format=%A text | egrep ^-r-- &&
>  			stat --format=%A text+x | egrep ^-r-x
>  		fi

Not a new problem but why do we need "stat" here?

Shouldn't "test -r", "! test -x", and their usual friends be
sufficient for the purpose of the test and are more portable?
