From: Santi <sbejar@gmail.com>
Subject: Re: Merge with local conflicts in new files
Date: Wed, 17 May 2006 00:12:31 +0200
Message-ID: <8aa486160605161512g4d38b7f0y@mail.gmail.com>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 00:12:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg7mN-0005Ee-FI
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWEPWMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWEPWMc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:12:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:16718 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932201AbWEPWMc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 18:12:32 -0400
Received: by wx-out-0102.google.com with SMTP id s6so60473wxc
        for <git@vger.kernel.org>; Tue, 16 May 2006 15:12:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OcPMQ6XsTVyH+qKT27TcfgorKIWZQyg2Ym1sQJ7hEdSR8J/rxNpUrrOi3rxi8W7xgpP8rOtweZQWxCBjKw8Rjsi9kVebsZ+Ak8JKX+BEfnV06YqpUG8i1YoacoWO/Q59E+NzF4XzXNq9X7+6R49V7q6I1BwuxwoWCH3B7iTiPuY=
Received: by 10.70.77.7 with SMTP id z7mr308337wxa;
        Tue, 16 May 2006 15:12:31 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Tue, 16 May 2006 15:12:31 -0700 (PDT)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <8aa486160605161500m1dd8428cj@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20140>

Sorry, the test is wrong. Use this:

test_description='Test merge with local conflicts in new files'
. ./test-lib.sh

test_expect_success 'prepare repository' \
'echo "Hello" > init &&
git add init &&
git commit -m "Initial commit" &&
git checkout -b B &&
echo "foo" > foo &&
git add foo &&
git commit -m "File: foo" &&
git checkout master &&
echo "bar" > foo &&
'

test_expect_code 1 'Merge with local conflicts in new files' 'git
merge "merge msg" HEAD B'

test_done
