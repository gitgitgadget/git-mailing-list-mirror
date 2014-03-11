From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Tue, 11 Mar 2014 11:13:50 -0700
Message-ID: <xmqqbnxcr4bl.fsf@gitster.dls.corp.google.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>
	<CAPig+cQoUW5dqSzs-wAVOD1xrbSzuzGoHCDKdmgT_BprngMbvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Pierre <benoit.pierre@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 19:14:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNRBf-0001gz-Ag
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 19:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbaCKSNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 14:13:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbaCKSNy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 14:13:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B76B27443D;
	Tue, 11 Mar 2014 14:13:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EsQ+qArbN+liCZqbg0QP2SZkptc=; b=g77aVp
	m6sauc9LCSVjBh+uEUeNrqqbV9tdDzbjxU6QbeTzBZQRssmQRZP0tKebPMeyc3AA
	A/ala3+mOR5QurzXWiP5ChaUT3NJQg9QsEPUmEuenqL+Of72/qqsfdIGBhOp7OO1
	Z5E+4p41TMrmOon/fvy6SpEJrxf40FhnpawME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=azsDZVUN2OUDEPnJqmRT/MCUDDBoXdGv
	HgPJROuDO9fW82h+KO8aPuHXd4JEW/niUQ4cEPY9tBQVe63e5FW0IfWhnDX0ZvjV
	gZP8VhshGsk+wyIwkZLZMFcQf1ZE69UyFbPIWzP26ad4Ha2A16ZQC/pbysuNuQud
	mc3vgBLCShM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A72917443C;
	Tue, 11 Mar 2014 14:13:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C826E7443A;
	Tue, 11 Mar 2014 14:13:52 -0400 (EDT)
In-Reply-To: <CAPig+cQoUW5dqSzs-wAVOD1xrbSzuzGoHCDKdmgT_BprngMbvQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 10 Mar 2014 16:20:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6ED278C-A948-11E3-8F46-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243876>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 10, 2014 at 2:49 PM, Benoit Pierre <benoit.pierre@gmail.com> wrote:
>> Add (failing) test: with commit changing the environment to let hooks
>> now that no editor will be used (by setting GIT_EDITOR to ":"), the
>> "edit hunk" functionality does not work (no editor is launched and the
>> whole hunk is committed).
>>
>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>> ---
>>  t/t7513-commit_-p_-m_hunk_edit.sh | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>  create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh
>
> Is it possible to give this file a name less unusual and more
> consistent with other test scripts? Perhaps choose a more generic name
> which may allow other similar tests to be added to the file in the
> future (if needed)?

Surely.  There are "reset-patch" and "checkout-patch" tests, and if
we were to add something like this, I'd imagine "commit-patch" would
be a logical name for the new test.

>> diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh
>> new file mode 100755
>> index 0000000..994939a
>> --- /dev/null
>> +++ b/t/t7513-commit_-p_-m_hunk_edit.sh
>> @@ -0,0 +1,34 @@
>> +#!/bin/sh
>> +
>> +test_description='hunk edit with "commit -p -m"'
>> +. ./test-lib.sh
>> +
>> +if ! test_have_prereq PERL
>> +then
>> +       skip_all="skipping '$test_description' tests, perl not available"
>> +       test_done
>> +fi
>> +
>> +test_expect_success 'setup (initial)' '
>> +       echo line1 >file &&
>> +       git add file &&
>> +       git commit -m commit1 &&
>> +       echo line3 >>file &&
>> +       cat >expect <<-\EOF
>> +       diff --git a/file b/file
>> +       index a29bdeb..c0d0fb4 100644
>> +       --- a/file
>> +       +++ b/file
>> +       @@ -1 +1,2 @@
>> +        line1
>> +       +line2
>> +       EOF
>
> In the previous review, the suggestion was that creation of 'expect'
> should be moved to the test below where it is actually used rather
> than into the 'setup' phase above.
>
>> +'
>> +
>> +test_expect_failure 'edit hunk "commit -p -m message"' '
>> +       echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 file &&
>> +       git diff HEAD^ HEAD >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_done
>> --
>> 1.9.0
