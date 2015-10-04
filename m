From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 3/4] git-p4: Fix t9815 git-p4-submit-fail test case on OS X
Date: Sun, 4 Oct 2015 11:44:55 -0700
Message-ID: <90C13A5C-AB19-4E5C-A317-15B3D182444D@gmail.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com> <1443981977-64604-4-git-send-email-larsxschneider@gmail.com> <xmqqegha1oj6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	pw@padd.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:45:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZioHU-0000BQ-Gn
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbbJDSpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:45:01 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36991 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbbJDSpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:45:00 -0400
Received: by wicfx3 with SMTP id fx3so87521035wic.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y5pFdxcfMrj26JppSKkCoNSeMLedmo6QPlf0WEHcs+o=;
        b=JaqhtSkA5X2nYWZWBMZ7mbvXrpZsnmVS+0YBAzGENhAAFdDsoIV99i/pnaAm1xxncZ
         HxDys3rqp5EeSRQH3hExRQMGunExuv6vZmEMqW0SDKbg1t3I616ngF4nD3j9wbzGXqoi
         Cmxy+sz9H97mwvtIpTh0QsyKCmsmUGtyIGsz5OrPd5dSncikJboYWn9QZEr+euaRAlyV
         PdRJQ/g53Fh9+xx3GBDqGr7n9RAY0YxfaIpgenYuamWGN16wiJym1ddelLoa+rgijmqs
         g6YGDn7MsOOsh7GMe6zvx2cBna6hK3SL9hz4VR1l4524pCZD8cZz4/mGV/HwnJbx59pn
         MlRQ==
X-Received: by 10.194.5.135 with SMTP id s7mr31335442wjs.153.1443984299226;
        Sun, 04 Oct 2015 11:44:59 -0700 (PDT)
Received: from remdbq1n32.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id ht5sm10582693wib.10.2015.10.04.11.44.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:44:58 -0700 (PDT)
In-Reply-To: <xmqqegha1oj6.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279021>


On 04 Oct 2015, at 11:23, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> +		if test_have_prereq CYGWIN; then
>> +			: # NOOP
>> +		elif test_have_prereq DARWIN; then
>> +			stat -f %Sp text | egrep ^-r-- &&
>> +			stat -f %Sp text+x | egrep ^-r-x
>> +		else
>> 			stat --format=%A text | egrep ^-r-- &&
>> 			stat --format=%A text+x | egrep ^-r-x
>> 		fi
> 
> Not a new problem but why do we need "stat" here?
> 
> Shouldn't "test -r", "! test -x", and their usual friends be
> sufficient for the purpose of the test and are more portable?

Good question. The stat call was introduced with df9c545 by Pete Wyckoff.
@Pete, @Luke: Are you aware of any particular reason for stat?

Thanks,
Lars
