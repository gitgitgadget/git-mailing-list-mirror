From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 1/2] git-p4: Test changelists touching two branches
Date: Thu, 24 May 2012 23:42:06 +0100
Message-ID: <CAOpHH-U+cG2DvTtWD25JNgLYKrNcwXgqysA0G-wr5DFhLG-DAg@mail.gmail.com>
References: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
 <1337729891-27648-2-git-send-email-vitor.hda@gmail.com> <20120524010805.GA26443@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri May 25 00:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXgjz-0004NI-RF
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 00:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab2EXWmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 18:42:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39489 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2EXWmi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 18:42:38 -0400
Received: by bkcji2 with SMTP id ji2so255515bkc.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bxkXFfkcfpghlcxu8TJtPysQGO68TXiTxKVbV0ZT4s8=;
        b=DkV3ywokCH17B5B84zVvoG0YgGby1APLUkuSL2gTlxFTshquR3JEOCHarzXuzwqj/W
         f2P25OoOzDKMHRpd9cwtjJtTWbtsdPWyHxA3ew9omO1A4C33eJJIDRTTJaBA7IUou+2U
         iVib+moBbrcH4Zpe/cfP5dca9ULAlBQCYpfUjzFuI5wrO2Sbh7pTIepPECIHsI+tr6QW
         HptQauANNBtZsIkgUBsaxxGQdKWcz9XMw3S+cycUnbCSgAIcaCxL7zwq34KU2+e168to
         VS8r4i5D6/4Ym7y6/GDZHDSFVd26GAPh9rxdEpn6Af+ScoXpnIrPzFuvL4uKXLDb9eAP
         PrZg==
Received: by 10.204.157.23 with SMTP id z23mr489685bkw.71.1337899357163; Thu,
 24 May 2012 15:42:37 -0700 (PDT)
Received: by 10.204.129.215 with HTTP; Thu, 24 May 2012 15:42:06 -0700 (PDT)
In-Reply-To: <20120524010805.GA26443@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198440>

On Thu, May 24, 2012 at 2:08 AM, Pete Wyckoff <pw@padd.com> wrote:
> vitor.hda@gmail.com wrote on Wed, 23 May 2012 00:38 +0100:
>> It is possible to modify two different branches in P4 in a single
>> changelist. git-p4 correctly detects this and commits the relevant
>> changes to the different branches separately. This test proves that =
and
>> avoid future regressions in this behavior.
>>
>> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
>> ---
>> =A0t/t9801-git-p4-branch.sh | =A0 54 +++++++++++++++++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 54 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
>> index 2859256..89d8c59 100755
>> --- a/t/t9801-git-p4-branch.sh
>> +++ b/t/t9801-git-p4-branch.sh
>> @@ -306,6 +306,60 @@ test_expect_success 'git p4 clone complex branc=
hes' '
>> =A0 =A0 =A0 )
>> =A0'
>>
>> +# Move branch3/file3 to branch4/file3 in a single changelist
>> +test_expect_success 'git p4 submit to two branches in a single chan=
gelist' '
>> + =A0 =A0 test_when_finished cleanup_git &&
>> + =A0 =A0 test_create_repo "$git" &&
>
> You can skip the git bits here. =A0This is just setup for the next
> test.

What about the parentheses in the next line, is it necessary? Or can I
simply remove that pair of parentheses and unindent the code in
between?

Thanks,
Vitor

> Ack everything else. =A0Nice to have the extra tests.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Pete
>
>> + =A0 =A0 (
>> + =A0 =A0 =A0 =A0 =A0 =A0 cd "$cli" &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 integrate //depot/branch3/file3 //depot=
/branch4/file3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 delete //depot/branch3/file3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 submit -d "Move branch3/file3 to branch=
4/file3"
>> + =A0 =A0 )
>> +'
>> +
>> +# Confirm that changes to two branches done in a single changelist
>> +# are correctly imported by git p4
>> +test_expect_success 'git p4 sync changes to two branches in the sam=
e changelist' '
>> + =A0 =A0 test_when_finished cleanup_git &&
>> + =A0 =A0 test_create_repo "$git" &&
>> + =A0 =A0 (
>> + =A0 =A0 =A0 =A0 =A0 =A0 cd "$git" &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git config git-p4.branchList branch1:branc=
h2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git config --add git-p4.branchList branch1=
:branch3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git config --add git-p4.branchList branch1=
:branch4 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git config --add git-p4.branchList branch1=
:branch5 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git p4 clone --dest=3D. --detect-branches =
//depot@all &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git log --all --graph --decorate --stat &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git reset --hard p4/depot/branch1 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file1 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 grep update file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git reset --hard p4/depot/branch2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file1 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_missing file3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 ! grep update file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git reset --hard p4/depot/branch3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file1 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_missing file3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 grep update file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git reset --hard p4/depot/branch4 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file1 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 ! grep update file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 git reset --hard p4/depot/branch5 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file1 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file3 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 ! grep update file2 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_missing .git/git-p4-tmp
>> + =A0 =A0 )
>> +'
>> +
>> =A0test_expect_success 'kill p4d' '
>> =A0 =A0 =A0 kill_p4d
>> =A0'
>> --
>> 1.7.7.rc2.14.g5e044.dirty
>>
