From: CoDEmanX <codemanx@gmx.de>
Subject: List tags for a certain branch
Date: Sun, 23 Aug 2015 17:27:46 +0200
Message-ID: <55D9E672.4050503@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 17:28:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTXBu-0002tl-Rh
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 17:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbbHWP1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 11:27:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:64987 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbbHWP1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 11:27:51 -0400
Received: from [192.168.2.107] ([62.157.57.179]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LyF3F-1Yhjfs2O6n-015Yce for <git@vger.kernel.org>;
 Sun, 23 Aug 2015 17:27:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:TJ4EbGb8fpRX7vk6MwDnrVVkbqST7VUkY33o1HymM83i1AJAGcc
 tOhWwuNqrKhvsD2BFAyYNvxTBxm8QNpIV2LQpCSLFTsqQPPcS5hxmT6+sXzrLO1PkjIxvZo
 s11JP6WusqExuKvfARLOm5L/1P4ONsxGqwEEDgxATbO0TwjpmDZFiErB6YlMYf96s0kut74
 LBUqySjnwAkVsOzhl41Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GbePVUPHc60=:MtYVM3k0glCFUSq8NyNR9c
 C4r042TWNWdqMGPjyGV87meyIDISnjUdyqCZAjITJg3tSAgi4JRGbBBUA6955GY+n7U3TyERP
 2Bant1l0OGx19TLlOBtQvLTdJbY7CWld9GPRjr4MpTPjvWJDa5f62juw/KZtDyCm83z/iJLC+
 XO8w9YwCRb1Cx7la1P7mbpMZvD8LUjsxSCm0a40kV0Yyc0lXd2ihM4AwA09AJ/NQEqqE8eVko
 /rcgk4ROlaYkGWQeL8Uzxve8z0EgQLEoYHePWGF6tu8efNx8Bpcx5gUZ/i8Z9vxZDlUVKurBl
 +BvUW4ZAIto4eGzUZXIhA048d8PFI0JnqcR2Jq9tBNoKVGaWz6uWUeuqzp7fI2zaDtzLuqOXf
 aCcfbRkqRcHSXfLPNGV5b6KDPC1wWSU5uG/hCM1YnaSBQuMTnuAquclT3jz+yv1+oNiP5rAMf
 iwBsAY+A+Lqv4q5DGWcogWdzLOTud3lYTzjMfRLFD4GFa43oq2O+VBM4jRiK9lhfdbJk/1Nr5
 0V/tjemoRYPGEqHiaMfV2VxBK+ctZLANZuiUZO3V6tN2ADYBBkR+J8KQv63e9Nrwq7/YLK3i7
 ZtUv9Le8O/pdcBj2ntVI1uGVZqPVWZgZDQHfzH8AQRIsYrIJuAJU03v8rmQ/9a9+ttQWT6HEO
 49tksvckMmKG2i2ZcpbeEQHe7/VvPzh4BMNgMb7r6Zxnplv++V7cEiwkUfzWWtBckWGOJXHH7
 acXr6l7LIZkIAjKu1PxgJjsnIqkdJ0PV34vmhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276409>

Hi everyone,

the question how to list tags, that point to commits contained in a 
certain branch came up on StackOverflow couple times, and this appears 
to be the only fast solution (example for local devel branch):

     git log --simplify-by-decoration --decorate --pretty=%d 
"refs/heads/devel" | fgrep 'tag: '

It would be much much simpler, if the tag command supporter an optional 
parameter to specify a branch:

     git tag --list --branch devel

It should result in something like:

Test-Tag1
Test-Tag2
Test-Tag3
Another-Tag
And-Another

... even if all three Test-Tag* tags point to the same commit!

What above mentioned git log-solution does in this situtation is:

  (HEAD, tag: Test-Tag1, tag: Test-Tag2, Test-Tag3, fork/devel, devel)
  (tag: Another-Tag)
  (tag: And-Another)


BTW: git describe FULL_HASH can't be used to return all tags that point 
to the given hash. The only workaround seems to be:

     git for-each-rev ref/tags | grep FULL_HASH


I hope you consider to add the proposed --branch option to a future git 
version. Thanks!

SO question that started the discussion:

http://stackoverflow.com/questions/32166548/how-to-list-all-tags-within-a-certain-git-branch

Best,
Cody
