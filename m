From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?]: unpack-file behavior for blobs corresponding to symlinks
Date: Fri, 19 Sep 2008 08:50:13 -0700
Message-ID: <7v4p4cuocq.fsf@gitster.siamese.dyndns.org>
References: <51419b2c0809190731j5a77b8ccmba2feecb9c44cc1c@mail.gmail.com>
 <237967ef0809190751k38defaabk9efc74711f7c63c4@mail.gmail.com>
 <51419b2c0809190755l2aa01558l30e07c4141f8d4e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mikael Magnusson" <mikachu@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 17:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgiGZ-0002EB-RF
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 17:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYISPuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 11:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbYISPuW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 11:50:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbYISPuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 11:50:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8DCD963D66;
	Fri, 19 Sep 2008 11:50:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6331B63D65; Fri, 19 Sep 2008 11:50:16 -0400 (EDT)
In-Reply-To: <51419b2c0809190755l2aa01558l30e07c4141f8d4e0@mail.gmail.com>
 (Elijah Newren's message of "Fri, 19 Sep 2008 08:55:36 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9DC2E38-8662-11DD-ABB7-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96295>

"Elijah Newren" <newren@gmail.com> writes:

> On Fri, Sep 19, 2008 at 8:51 AM, Mikael Magnusson <mikachu@gmail.com> wrote:
>> This is not a bug. The type of a file is in the tree, not the blob, see:
>>
>> % echo -n foo > file
>> % ln -s foo symlink
>> % git add file symlink
>> % git commit
>> Created initial commit 31ad9b0 on master: file and symlink
>>  2 files changed, 2 insertions(+), 0 deletions(-)
>>  create mode 100644 file
>>  create mode 120000 symlink
>> % git ls-tree HEAD
>> 100644 blob 19102815663d23f8b75a47e7a01965dcdc96468c    file
>> 120000 blob 19102815663d23f8b75a47e7a01965dcdc96468c    symlink
>
> Good to know.  Given the mode (100644 or 120000) and the sha1sum, is
> there a git command that will create-my-file for me,...

        git checkout -- that-path      ;# from the index
        git checkout commit that-path  ;# from the commit/tree
