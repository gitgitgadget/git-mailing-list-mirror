From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 21 Jan 2013 17:11:45 +0100
Message-ID: <87a9s2o6ri.fsf@pctrast.inf.ethz.ch>
References: <50D861EE.6020105@giref.ulaval.ca>
	<50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca>
	<50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca>
	<CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
	<50F8273E.5050803@giref.ulaval.ca>
	<871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
	<50F829A9.7090606@calculquebec.ca>
	<871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
	<50F98B53.9080109@giref.ulaval.ca>
	<CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <kusmabite@gmail.com>,
	Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Boisvert 
	<sebastien.boisvert@calculquebec.ca>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:12:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxJyl-00040t-3g
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 17:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab3AUQLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 11:11:49 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:56532 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab3AUQLs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 11:11:48 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 21 Jan
 2013 17:11:45 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.208.154) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 21 Jan 2013 17:11:45 +0100
In-Reply-To: <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
	(Erik Faye-Lund's message of "Mon, 21 Jan 2013 14:29:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.208.154]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214125>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Fri, Jan 18, 2013 at 6:50 PM, Eric Chamberland
> <Eric.Chamberland@giref.ulaval.ca> wrote:
>> Good idea!
>>
>> I did a strace and here is the output with the error:
>>
>> http://www.giref.ulaval.ca/~ericc/strace_git_error.txt
>>
>> Hope it will be insightful!
>
> This trace doesn't seem to contain child-processes, but instead having
> their stderr inlined into the log. Try using "strace -f" instead...

I happen to have access to a lustre FS on the brutus cluster of ETH
Zurich, so I figured I could give it a shot.

What's odd is that while I cannot reproduce the original problem, there
seems to be another issue/bug with utime():

  $ strace -f -o ~/gc.trace git gc
  warning: failed utime() on .git/objects/68/tmp_obj_sCAEVc: Interrupted system call
  warning: failed utime() on .git/objects/a6/tmp_obj_3cdB2c: Interrupted system call
  warning: failed utime() on .git/objects/69/tmp_obj_lbU3Xc: Interrupted system call
  warning: failed utime() on .git/objects/c3/tmp_obj_EU97Wc: Interrupted system call
  warning: failed utime() on .git/objects/3e/tmp_obj_tb2j3c: Interrupted system call
  warning: failed utime() on .git/objects/15/tmp_obj_e6zMXc: Interrupted system call
  warning: failed utime() on .git/objects/54/tmp_obj_ExOJVc: Interrupted system call
  warning: failed utime() on .git/objects/e3/tmp_obj_GtPw4c: Interrupted system call
  warning: failed utime() on .git/objects/21/tmp_obj_Xex32c: Interrupted system call
  warning: failed utime() on .git/objects/1a/tmp_obj_CzwsZc: Interrupted system call
  warning: failed utime() on .git/objects/18/tmp_obj_o6fp3c: Interrupted system call
  warning: failed utime() on .git/objects/32/tmp_obj_Ih0G4c: Interrupted system call
  warning: failed utime() on .git/objects/41/tmp_obj_1RXV1c: Interrupted system call
  Counting objects: 137744, done.
  Delta compression using up to 48 threads.
  Compressing objects: 100% (36510/36510), done.
  Writing objects: 100% (137744/137744), done.
  Total 137744 (delta 101591), reused 135512 (delta 99472)

The trace is here (2.1MB compressed):

  http://thomasrast.ch/download/gc.trace.bz2

For the test I used a clone of another git.git I had around.  I think
the error is from sha1_file.c:2564.  While that doesn't look too
important (see ca11b212 for context), it does raise the question: what
other system calls that we never expect to EINTR can do this on
sufficiently arcane system/FS combinations?


Peff's test ran without any apparent issue for a few minutes.  I also
ran an extended version (at the end) that sets alarms, so as to actually
get interrupted.  That proved more interesting.  I had to fix verify()
and write_in_full() to account for EINTR in read()/write(), as those
seem likely to fail.  I also got link() to fail:

  $ ~/lustre-peff-reproducer 
  unable to create hard link: Interrupted system call
  unable to open index file: No such file or directory

but it took a long time.  Unfortunately, when running it with strace I
managed to panic the host I ran it on:

  $ strace -o ~/peff-reproducer.trace ~/lustre-peff-reproducer 

  Message from syslogd@brutus1 at Jan 21 17:09:43 ...                                                    
   kernel:LustreError: 37417:0:(osc_lock.c:1182:osc_lock_enqueue()) ASSERTION( ols->ols_state == OLS_NEW ) failed: Impossible state: 4

  Message from syslogd@brutus1 at Jan 21 17:09:43 ...
   kernel:LustreError: 37417:0:(osc_lock.c:1182:osc_lock_enqueue()) LBUG

  Message from syslogd@brutus1 at Jan 21 17:09:43 ...
   kernel:Kernel panic - not syncing: LBUG

Yay for now having to explain this to the cluster team.


I tried finding a standard that limits the syscalls to which EINTR
applies, without too much success.  I'm not sure how far I should trust
my manpages, but while some of them explicitly list EINTR as a possible
error (read, write, etc.) link() does not.  (And the linux manpages
agree with the POSOIX ones for once.)

If somebody finds such a standard, we could of course use it to blame
lustre instead :-)

In the absence of it, wouldn't we in theory have to write a simple
loop-on-EINTR wrapper for *all* syscalls?

Of course there's the added problem that when open(O_CREAT|O_EXCL) fails
with EINTR, it's hard to tell whether a file that may now exist is
indeed yours or some other process's.

--- 8< ----
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/time.h>
#include <signal.h>
#include <errno.h>

struct itimerval itv;

static int randomize(unsigned char *buf, int len)
{
  int i;
  len = rand() % len;
  for (i = 0; i < len; i++)
    buf[i] = rand() & 0xff;
  return len;
}

static int check_eof(int fd)
{
  int ch;
  int r = read(fd, &ch, 1);
  if (r < 0) {
    perror("read error after expected EOF");
    return -1;
  }
  if (r > 0) {
    fprintf(stderr, "extra byte after expected EOF");
    return -1;
  }
  return 0;
}

static int verify(int fd, const unsigned char *buf, int len)
{
  while (len) {
    char to_check[4096];
    int got = read(fd, to_check,
                   len < sizeof(to_check) ? len : sizeof(to_check));

    if (got < 0 && errno == EINTR)
      continue;
    if (got < 0) {
      perror("unable to read");
      return -1;
    }
    if (got == 0) {
      fprintf(stderr, "premature EOF (%d bytes remaining)", len);
      return -1;
    }
    if (memcmp(buf, to_check, got)) {
      fprintf(stderr, "bytes differ");
      return -1;
    }

    buf += got;
    len -= got;
  }

  return check_eof(fd);
}

int write_in_full(int fd, const unsigned char *buf, int len)
{
  while (len) {
    int r = write(fd, buf, len);
    if (r < 0 && errno == EINTR)
      continue;
    if (r < 0)
      return -1;
    buf += r;
    len -= r;
  }
  return 0;
}

int move_into_place(const char *old, const char *new)
{
  if (link(old, new) < 0) {
    perror("unable to create hard link");
    return 1;
  }
  unlink(old);
  return 0;
}

void handle_alarm(int signal)
{
}

int main(void)
{
  struct sigaction sa;

  sa.sa_handler = handle_alarm;
  sa.sa_flags = SA_RESTART;
  sigaction(SIGALRM, &sa, NULL);

  itv.it_interval.tv_sec = 0;
  itv.it_interval.tv_usec = 10000;
  itv.it_value.tv_sec = 0;
  itv.it_value.tv_usec = 100000;
  setitimer(ITIMER_REAL, &itv, NULL);

  while (1) {
    static unsigned char junk[1024*1024];
    int len = randomize(junk, sizeof(junk));
    int fd;

    /* clean up from any previous round */
    unlink("tmpfile");
    unlink("final.idx");

    fd = open("tmpfile", O_WRONLY|O_CREAT, 0666);
    if (fd < 0) {
      perror("unable to open tmpfile");
      return 1;
    }
    if (write_in_full(fd, junk, len) < 0 ||
        fsync(fd) < 0 ||
        close(fd) < 0) {
      perror("unable to write");
      return 1;
    }

    if (move_into_place("tmpfile", "final.idx") < 0)
      return 1;

    fd = open("final.idx", O_RDONLY);
    if (fd < 0) {
      perror("unable to open index file");
      return 1;
    }
    if (verify(fd, junk, len) < 0)
      return 1;
    close(fd);
  }
}
