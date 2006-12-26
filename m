From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: cgit vs. gitweb
Date: Tue, 26 Dec 2006 01:04:39 +0100
Message-ID: <8c5c35580612251604s5e211518yd958fdc2e73232ef@mail.gmail.com>
References: <8c5c35580612250921o765e141cq27f81b06364d0a4@mail.gmail.com>
	 <empikd$s32$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 26 01:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyzoS-0003MJ-Uv
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 01:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbWLZAEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 19:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbWLZAEm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 19:04:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:50186 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbWLZAEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 19:04:41 -0500
Received: by nf-out-0910.google.com with SMTP id o25so4626726nfa
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 16:04:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LER6kvXCv1mS8UEB2EejtSxgPi2NCoE2K2BU40FnKJyEGremAhd2i79Jdawk2z+wv2WhnIqTeqRgUfMOdZWQOFm81ka8UUFTjsZi9vAbwix8sa9j7wU9F3DTIiAqKYs2JVrmkFQFuiNrE6SQ9xa/Qz33MMBDfWd/uJra1dTTH9Y=
Received: by 10.82.169.4 with SMTP id r4mr499935bue.1167091479710;
        Mon, 25 Dec 2006 16:04:39 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Mon, 25 Dec 2006 16:04:39 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <empikd$s32$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35400>

On 12/25/06, Jakub Narebski <jnareb@gmail.com> wrote:
> [Cc: git@vger.kernel.org]
>
> Lars Hjemli wrote:
>
> > I wanted to compare cgit against gitweb to see the effect of using
> > libgit and internal caching. So I ran the attached scripts against
> > http://hjemli.net/git/ and http://hjemli.net/cgi-bin/gitweb.cgi as a
> > very simplistic benchmark.
>
> First, could you try this also with mod_perl, not only CGI?

Well, not easily I'm afraid: I'm running slackware 11 w. apache
1.3.37, w.o. mod_perl, and when trying to install mod_perl tonight I
ended up w.o. a working httpd :-(

But I guess someone who has tested gitweb w. and w.o. mod_perl could
come up with an estimate on the difference between them?


> Could you include ApacheBench (ab) results?

Sure (I didn't know about this tool, thanks for the pointer)

Here's the result of a few requests:

$ ab -n 1000 -c 1 http://box1/git/cgit/log/?h=master
This is ApacheBench, Version 1.3d <$Revision: 1.73 $> apache-1.3
[...snip...]
Document Path:          /git/cgit/log/?h=master
Document Length:        9373 bytes

Concurrency Level:      1
Time taken for tests:   5.788 seconds
Complete requests:      1000
Failed requests:        0
Broken pipe errors:     0
Total transferred:      9604000 bytes
HTML transferred:       9373000 bytes
Requests per second:    172.77 [#/sec] (mean)
Time per request:       5.79 [ms] (mean)
Time per request:       5.79 [ms] (mean, across all concurrent requests)
Transfer rate:          1659.30 [Kbytes/sec] received

Connnection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0     0    0.0      0     0
Processing:     3     5   19.0      3   206
Waiting:        3     5   19.0      3   206
Total:          3     5   19.0      3   206

Percentage of the requests served within a certain time (ms)
  50%      3
  66%      3
  75%      3
  80%      3
  90%      4
  95%      4
  98%      4
  99%      4
 100%    206 (last request)


$ ab -n 1000 -c 10 http://box1/git/cgit/log/?h=master
[..snip..]
Concurrency Level:      10
Time taken for tests:   3.421 seconds
Complete requests:      1000
Failed requests:        0
Broken pipe errors:     0
Total transferred:      9604000 bytes
HTML transferred:       9373000 bytes
Requests per second:    292.31 [#/sec] (mean)
Time per request:       34.21 [ms] (mean)
Time per request:       3.42 [ms] (mean, across all concurrent requests)
Transfer rate:          2807.37 [Kbytes/sec] received

Connnection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0     0    0.0      0     1
Processing:     3    31   98.8     13  1037
Waiting:        3    31   98.8     13  1037
Total:          3    31   98.8     13  1037
ERROR: The median and mean for the initial connection time are more
than twice the standard
       deviation apart. These results are NOT reliable.

Percentage of the requests served within a certain time (ms)
  50%     13
  66%     16
  75%     17
  80%     20
  90%     27
  95%     61
  98%    335
  99%    665
 100%   1037 (last request)

$ ab -n 1000 -c 100 http://box1/git/cgit/log/?h=master
[..snip..]Concurrency Level:      100
Time taken for tests:   3.450 seconds
Complete requests:      1000
Failed requests:        0
Broken pipe errors:     0
Total transferred:      9612547 bytes
HTML transferred:       9381316 bytes
Requests per second:    289.86 [#/sec] (mean)
Time per request:       345.00 [ms] (mean)
Time per request:       3.45 [ms] (mean, across all concurrent requests)
Transfer rate:          2786.25 [Kbytes/sec] received

Connnection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0     0    0.3      0     3
Processing:     9   322  143.8    311  1780
Waiting:        6   322  143.8    311  1780
Total:          9   322  143.6    311  1780

Percentage of the requests served within a certain time (ms)
  50%    311
  66%    316
  75%    321
  80%    323
  90%    334
  95%    383
  98%    737
  99%   1146
 100%   1780 (last request)

$ ab -n 100 -c 1 http://box1/cgi-bin/gitweb.cgi?p=cgit;a=shortlog
[...snip...]
Document Path:          /cgi-bin/gitweb.cgi?p=cgit
Document Length:        16636 bytes

Concurrency Level:      1
Time taken for tests:   21.908 seconds
Complete requests:      100
Failed requests:        0
Broken pipe errors:     0
Total transferred:      1678100 bytes
HTML transferred:       1663600 bytes
Requests per second:    4.56 [#/sec] (mean)
Time per request:       219.08 [ms] (mean)
Time per request:       219.08 [ms] (mean, across all concurrent requests)
Transfer rate:          76.60 [Kbytes/sec] received

Connnection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0     0    0.0      0     0
Processing:   216   219    1.0    219   222
Waiting:      216   219    0.9    219   221
Total:        216   219    1.0    219   222

Percentage of the requests served within a certain time (ms)
  50%    219
  66%    219
  75%    220
  80%    220
  90%    221
  95%    221
  98%    221
  99%    222
 100%    222 (last request)

$ ab -n 100 -c 10 http://box1/cgi-bin/gitweb.cgi?p=cgit;a=shortlog
[...snip...]
Concurrency Level:      10
Time taken for tests:   23.480 seconds
Complete requests:      100
Failed requests:        0
Broken pipe errors:     0
Total transferred:      1744006 bytes
HTML transferred:       1728636 bytes
Requests per second:    4.26 [#/sec] (mean)
Time per request:       2348.00 [ms] (mean)
Time per request:       234.80 [ms] (mean, across all concurrent requests)
Transfer rate:          74.28 [Kbytes/sec] received

Connnection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0     0    0.0      0     0
Processing:   216  2244  897.8   2044  4905
Waiting:      216  2244  897.8   2043  4905
Total:        216  2244  897.8   2044  4905

Percentage of the requests served within a certain time (ms)
  50%   2044
  66%   2566
  75%   3008
  80%   3119
  90%   3487
  95%   3591
  98%   4094
  99%   4171
 100%   4905 (last request)

$ ab -n 100 -c 50 http://box1/cgi-bin/gitweb.cgi?p=cgit;a=shortlog
[...snip...]
Concurrency Level:      50
Time taken for tests:   29.552 seconds
Complete requests:      100
Failed requests:        0
Broken pipe errors:     0
Total transferred:      1978127 bytes
HTML transferred:       1958697 bytes
Requests per second:    3.38 [#/sec] (mean)
Time per request:       14776.00 [ms] (mean)
Time per request:       295.52 [ms] (mean, across all concurrent requests)
Transfer rate:          66.94 [Kbytes/sec] received

Connnection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0     1    0.0      1     1
Processing:   221 11464 5725.4  11769 22556
Waiting:      221 11464 5725.5  11769 22556
Total:        221 11465 5725.6  11770 22557
ERROR: The median and mean for the initial connection time are more
than twice the standard
       deviation apart. These results are NOT reliable.

Percentage of the requests served within a certain time (ms)
  50%  11770
  66%  14899
  75%  16229
  80%  16535
  90%  19184
  95%  20065
  98%  22227
  99%  22397
 100%  22557 (last request)


This does seem to confirm the results of my homemade scripts.

-- 
larsh
